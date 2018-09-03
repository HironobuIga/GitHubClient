//
//  UIView+Constraint.swift
//  VariousCurrentSituations
//
//  Created by iganin on 2018/07/26.
//  Copyright © 2018年 iganin. All rights reserved.
//

import UIKit

extension UIView {
    func edges(to parentView: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        topAnchor.constraint(equalTo: parentView.topAnchor, constant: 0.0).isActive = true
        trailingAnchor.constraint(equalTo: parentView.trailingAnchor, constant: 0.0).isActive = true
        bottomAnchor.constraint(equalTo: parentView.bottomAnchor, constant: 0.0).isActive = true
        leadingAnchor.constraint(equalTo: parentView.leadingAnchor, constant: 0.0).isActive = true
    }
}
