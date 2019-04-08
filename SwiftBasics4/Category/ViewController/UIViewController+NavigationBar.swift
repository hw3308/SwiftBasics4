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
        
        static var navigationBarShadowHidden: Bool = false
    }
    
    /// 导航栏透明度
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
    
    
    /// 导航栏透阴影线是否显示
    var navigationBaShadowHidden: Bool {
        get { return objc_getAssociatedObject(self, &AssociatedKey.navigationBarShadowHidden) as? Bool ?? false }
        set { self.setNavigationBarShadow(newValue) }
    }
    
    /// 设置导航栏阴影线显示
    func setNavigationBarShadow(_ hidden: Bool) {
        objc_setAssociatedObject(self, &AssociatedKey.navigationBarShadowHidden
            , hidden, .OBJC_ASSOCIATION_RETAIN)
        self.updateNavigationBarShadow(hidden)
    }
    
    /// 更新导航栏阴影线显示
    func updateNavigationBarShadow(_ hidden:Bool) {
        
        var navigationBar:UINavigationBar?
        
        if self is UINavigationController{
            let nav = self as! UINavigationController
            navigationBar = nav.navigationBar
        }else if let nav = self.navigationController{
            navigationBar = nav.navigationBar
        }
        
        navigationBar?.shadowImage = hidden ? UIImage() : nil
        navigationBar?.setBackgroundImage(hidden ? UIImage() : nil, for: .default)
    }
}
