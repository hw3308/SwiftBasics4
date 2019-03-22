//
//  UIViewController+Top.swift
//  SwiftBasics4
//
//  Created by 侯伟 on 17/1/11.
//  Copyright © 2017年 侯伟. All rights reserved.
//

import Foundation
import UIKit


// MARK: Top view controller

extension UIViewController {
    
    /// 获取当前显示的 View Controller
    public static var topViewController: UIViewController? {
        var vc = UIApplication.shared.keyWindow?.rootViewController
        while true {
            if let nc = vc as? UINavigationController {
                vc = nc.visibleViewController
            } else if let tbc = vc as? UITabBarController {
                if let svc = tbc.selectedViewController {
                    vc = svc
                } else {
                    break
                }
            } else if let pvc = vc?.presentedViewController {
                vc = pvc
            } else {
                break
            }
        }
        return vc
    }
}
