//
//  UIView+LoadingExtension
//  VariousCurrentSituations
//
//  Created by iganin on 2018/07/19.
//  Copyright © 2018年 iganin. All rights reserved.
//

import UIKit

///表示用のIndicator本体 UIViewのExtension以外からの生成を防ぐためfileprivateにしています
fileprivate final class LoadingOverLayView: UIView {
    
    // MARK: - Property
    private var indicatorView: UIActivityIndicatorView!
    
    // MARK: - LifeCycle
    init(frame: CGRect, indicatorStyle: UIActivityIndicatorViewStyle) {
        indicatorView = UIActivityIndicatorView(activityIndicatorStyle: indicatorStyle)
        indicatorView.hidesWhenStopped = true
        super.init(frame: frame)
        addSubview(indicatorView)
        indicatorView.center = center
        backgroundColor = UIColor.black
        alpha = 0.4
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Method
    func startAnimation() {
        indicatorView.startAnimating()
    }
    
    func stopAnimation() {
        indicatorView.stopAnimating()
    }
}

// MARK: - UIView Extension
extension UIView {
    
    /// LoadingViewを表示します
    ///
    /// - Parameter indicatorStyle: UIActivityIndicatorViewのstyle（gray, white, whiteLarge)
    func showLoading(with indicatorStyle: UIActivityIndicatorViewStyle = .whiteLarge) {
        // Loading中にはView操作をして欲しくないためユーザー操作を不可にしています
        isUserInteractionEnabled = false
        let overLayView = LoadingOverLayView(frame: frame, indicatorStyle: indicatorStyle)
        addSubview(overLayView)
        overLayView.edges(to: self)
        overLayView.startAnimation()
    }
    
    /// 表示されているIndicatorViewを非表示にします
    func hideLoading() {
        // Loadingを非表示にしたタイミングでユーザー操作を可能にしています
        isUserInteractionEnabled = true
        subviews.forEach { subView in
            if let subView = subView as? LoadingOverLayView {
                subView.stopAnimation()
                subView.removeFromSuperview()
            }
        }
    }
}
