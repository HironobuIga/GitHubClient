//
//  ViewModel.swift
//  RxSwiftGitHubClient
//
//  Created by iganin on 2018/08/21.
//  Copyright © 2018年 iganin. All rights reserved.
//

import UIKit
import RxSwift
import APIKit

class ListViewModel: NSObject {
    
    // MARK: - Property
    private var cellIdentifier = "ListCell"
    private(set) var repos = Variable<[Repository]>([])
    private(set) var error = Variable<Error?>(nil)
    private let disposeBag = DisposeBag()
    
    // MARK: - Function
    func reloadData(userName: String) {
        let request = FetchRepositoriesRequest(userName: userName)
        Session.rx_response(request: request)
            .subscribe { [weak self] event in
                guard let `self` = self else { return }
                switch event {
                case .next(let repos): self.repos.value = repos
                case .error(let error): self.error.value = error
                case .completed: break
                }
        }.disposed(by: disposeBag)
    }
}

// MARK: - UITableViewDataSource
extension ListViewModel: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repos.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        return cell
    }
}
