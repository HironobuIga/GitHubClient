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
    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = viewModel
            tableView.rowHeight = UITableViewAutomaticDimension
            tableView.estimatedRowHeight = 58.0
        }
    }
    
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }
}

// MARK: - Private Function
private extension ViewController {
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
        
        // searchBar
    }
}

// MARK: - UITableViewDelegate
extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - UISearchBarDelegate
extension ViewController: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}
