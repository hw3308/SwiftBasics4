//
//  UIViewController+NavigationBar.swift
//  SwiftBasics4
//
//  Created by houwei on 2019/3/21.
//  Copyright © 2019年 侯伟. All rights reserved.
//

import Foundation
import UIKit
// MARK: NavigationBar

extension UIViewController {
    
    fileprivate struct AssociatedKey {
        static var navigationBarAlpha: CGFloat = 0
    }
    
    var navigationBarAlpha: CGFloat {
        get { return objc_getAssociatedObject(self, &AssociatedKey.navigationBarAlpha) as? CGFloat ?? 1 }
        set { self.setNavigationBarAlpha(newValue, animated: false) }
    }
    
    /// 设置内容透明度
    func setNavigationBarAlpha(_ alpha: CGFloat, animated: Bool) {
        objc_setAssociatedObject(self, &AssociatedKey.navigationBarAlpha, alpha, .OBJC_ASSOCIATION_RETAIN)
        self.updateNavigationBarAlpha(alpha, animated: animated)
    }
    
    /// 根据内容透明度更新UI效果
    func updateNavigationBarAlpha(_ alpha: CGFloat? = nil, animated: Bool) {
        guard let navigationBar = self.navigationController?.navigationBar else {return}
        
        if animated == true {
            UIView.beginAnimations(nil, context: nil)
        }
        
        let newAlpha = alpha ?? self.navigationBarAlpha
        
        for subview in navigationBar.subviews {
            let className = String(describing: subview.classForCoder)
            if className == "_UINavigationBarBackground" || className == "UINavigationItemView" {
                subview.alpha = newAlpha
            }
        }
        
        if animated == true {
            UIView.commitAnimations()
        }
    }
    
    /// 显示/隐藏 NavigationBar
    public func setNavigationBarHidden(_ hidden: Bool, animated: Bool) {
        self.navigationController?.setNavigationBarHidden(hidden, animated: animated)
    }
}
