//
//  ViewReusable.swift
//  VariousCurrentSituations
//
//  Created by iganin on 2018/08/07.
//  Copyright © 2018年 iganin. All rights reserved.
//

import Foundation
import UIKit

protocol ViewReusable: class { }

extension ViewReusable {
    static var reuseIdentifier: String {
        return String(describing: Self.self)
    }
}

extension ViewReusable where Self: UITableViewCell & NibLoadable {
    static func registerNibTo(_ tableView: UITableView) {
        let nib = Self.nib
        tableView.register(nib, forCellReuseIdentifier: reuseIdentifier)
    }
}
