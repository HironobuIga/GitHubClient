//
//  NibLoadable.swift
//  VariousCurrentSituations
//
//  Created by iganin on 2018/07/25.
//  Copyright © 2018年 iganin. All rights reserved.
//

import UIKit
import Foundation

protocol NibLoadable: class {
    static var nib: UINib { get }
}

extension NibLoadable {
    static var nib: UINib {
        return UINib(nibName: String(describing: self), bundle: Bundle(for: self))
    }
}

extension NibLoadable where Self: UIView {
    static func instantiateFromNib() -> Self {
        guard let view = nib.instantiate(withOwner: nil, options: nil).first as? Self else {
            fatalError()
        }
        return view
    }
}
