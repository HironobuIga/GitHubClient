//
//  ViewController.swift
//  RxSwiftGitHubClient
//
//  Created by iganin on 2018/08/08.
//  Copyright © 2018年 iganin. All rights reserved.
//

import UIKit
import APIKit
import RxSwift
import RxCocoa

final class ViewController: UIViewController {
    
    // MARK: - Property
    let disposeBag = DisposeBag()
    private let viewModel = ListViewModel()
    private var searchController: UISearchController!
    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = viewModel
            tableView.rowHeight = UITableViewAutomaticDimension
            tableView.estimatedRowHeight = 58.0
            RepositoryCell.registerNibTo(tableView)
        }
    }
    
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews()
        bind()
    }
}

// MARK: - Private Function
private extension ViewController {
    func setupSubviews() {
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = true
    }
    
    func bind() {
        // tableView
        viewModel.repos.asObservable()
            .filter {  repositories -> Bool in
                return !repositories.isEmpty
            }.subscribe(onNext: { [unowned self] repository in
                self.tableView.reloadData()
                }, onError: { error in
            }, onCompleted: { () in
            }) { () in
            }.disposed(by: disposeBag)
        
        // キーボードの表示、非表示に合わせてtableViewのinsetを変更する
        NotificationCenter.default.rx.notification(Notification.Name.UIKeyboardWillShow)
            .subscribe { [weak self] event in
                guard let `self` = self,
                    let keyboardHeight = event.element?.userInfo?[UIKeyboardFrameBeginUserInfoKey] else { return }
                self.tableView.contentInset.bottom = keyboardHeight as! CGFloat
        }.disposed(by: disposeBag)
        
        NotificationCenter.default.rx.notification(Notification.Name.UIKeyboardWillHide)
            .subscribe({ [weak self] event in
                guard let `self` = self,
                    let keyboardHeight = event.element?.userInfo?[UIKeyboardFrameEndUserInfoKey] else { return }
                self.tableView.contentInset.bottom = keyboardHeight as! CGFloat
            })
            .disposed(by: disposeBag)
    }
}

// MARK: - UITableViewDelegate
extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - UISearchResultsUpdating
extension ViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        self.viewModel.reloadData(userName: searchController.searchBar.text ?? "")
        self.navigationItem.title = searchController.searchBar.text
    }
}
