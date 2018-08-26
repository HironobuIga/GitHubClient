//
//  RepositoryCell.swift
//  RxSwiftGitHubClient
//
//  Created by iganin on 2018/08/25.
//  Copyright © 2018年 iganin. All rights reserved.
//

import UIKit
import PINRemoteImage

final class RepositoryCell: UITableViewCell {
    static let cellIdentifier = "ListCell"
    
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var authorFullNameLabel: UILabel!
    @IBOutlet weak var languageLabel: UILabel!
    
    func set(repository: Repository) {
        authorFullNameLabel.text = repository.fullName
        languageLabel.text = repository.language
        if let avatarUrlString = repository.owner?.avatarUrl {
            avatarImageView.pin_setImage(from: URL(string: avatarUrlString))
        }
    }
}
