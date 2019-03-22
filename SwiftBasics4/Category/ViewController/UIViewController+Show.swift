//
//  UIViewController+Show.swift
//  SwiftBasics4
//
//  Created by houwei on 2019/3/21.
//  Copyright © 2019年 侯伟. All rights reserved.
//

import Foundation
import UIKit
// MARK: 导航

extension UIViewController {
    
    /// 显示 view controller（根据当前上下文，自动选择 push 或 present 方式）
    public static func showViewController(_ controller: UIViewController, animated flag: Bool) {
        
        let topViewController = UIViewController.topViewController
        
        if let navigationController = topViewController as? UINavigationController {
            navigationController.pushViewController(controller, animated: flag)
        } else if let navigationController = topViewController?.navigationController {
            navigationController.pushViewController(controller, animated: flag)
        } else {
            topViewController?.present(controller, animated: flag, completion: nil)
        }
    }
    
    /// 显示 view controller（根据当前上下文，自动选择 push 或 present 方式）
    public func showViewControllerAnimated(_ animated: Bool) {
        UIViewController.showViewController(self, animated: animated)
    }
    
    /// 关闭 view controller（根据当前上下文，自动选择 pop 或 dismiss 方式）
    public static func closeViewControllerAnimated(_ animated: Bool) {
        UIViewController.topViewController?.closeViewControllerAnimated(animated)
    }
    
    /// 关闭 view controller（根据当前上下文，自动选择 pop 或 dismiss 方式）
    public func closeViewControllerAnimated(_ animated: Bool) {
        if let controller = navigationController, controller.viewControllers.count > 1 {
            controller.popViewController(animated: animated)
        } else {
            dismiss(animated: animated, completion: nil)
        }
    }
}
