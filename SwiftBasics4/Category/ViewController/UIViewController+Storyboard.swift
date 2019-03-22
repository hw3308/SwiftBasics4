//
//  UIViewController+Storyboard.swift
//  SwiftBasics4
//
//  Created by houwei on 2019/3/21.
//  Copyright © 2019年 侯伟. All rights reserved.
//

import Foundation

// MARK: Storyboard

extension UIViewController {
    
    /// 从 Storyboard 中获取 ViewController
    public static func viewControllerWithIdentifier(_ id: String, storyboardName name: String) -> UIViewController {
        let storyboard = UIStoryboard(name: name, bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: id)
    }
}
