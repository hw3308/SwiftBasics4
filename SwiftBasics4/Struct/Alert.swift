//
//  Alert.swift
//  SwiftBasics4
//
//  Created by houwei on 2019/2/28.
//  Copyright © 2019年 侯伟. All rights reserved.
//

import UIKit

struct Alert {
    
    public static func defalutAlert(_ message: String!, title: String! = nil,completion: (() -> Void)? = nil) {
        alert(message, title: title, actionTitile: "我知道了", completion: completion)
    }
    
    public static func alert(_ message: String!, title: String! = nil,actionTitile:String!,completion: (() -> Void)? = nil) {
        let controller = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        controller.addAction(UIAlertAction(title: actionTitile, style: .default) { action in
            completion?()
        })
            
        UIViewController.topViewController?.present(controller, animated: true, completion: nil)
    }
    
    public static func defaluteConfirm(_ message: String, title: String! = nil, completion: @escaping (Bool) -> Void) {
        let controller = UIAlertController(title: title, message: message, preferredStyle: .alert)
        controller.addAction(UIAlertAction(title: "取消", style: .cancel) { action in
            completion(false)
        })
        controller.addAction(UIAlertAction(title: "确定", style: .default) { action in
            completion(true)
        })
        UIViewController.topViewController?.present(controller, animated: true, completion: nil)
    }
    
    public static func confirm(_ message: String, title: String! = nil,actions:[String]!, completion: @escaping (_ index:Int) -> Void) {
        let controller = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        for (index,actionTitle) in actions.enumerated() {
            let action:UIAlertAction = UIAlertAction(title: actionTitle, style: .default) { action in
                completion(index)
            }
            controller.addAction(action)
        }
        UIViewController.topViewController?.present(controller, animated: true, completion: nil)
    }
    
    public static func defalutPrompt(_ message: String, title: String! = nil,  text: String! = nil, placeholder: String! = nil, completion: @escaping (String?) -> Void) {
        let controller = UIAlertController(title: title, message: message, preferredStyle: .alert)
        controller.addAction(UIAlertAction(title: "取消", style: .cancel) { action in
            controller.dismiss(animated: true, completion: nil)
            completion(nil)
        })
        controller.addAction(UIAlertAction(title: "确定", style: .default) { action in
            controller.dismiss(animated: true, completion: nil)
            completion(controller.textFields?[0].text ?? "")
        })
        controller.addTextField { textField in
            if let value = text {
                textField.text = value
            }
            if let ph = placeholder {
                textField.placeholder = ph
            }
        }
        UIViewController.topViewController?.present(controller, animated: true, completion: nil)
    }
    
    public static func prompt(_ message: String, title: String! = nil,actions:[String]!, text: String! = nil, placeholder: String! = nil, completion: @escaping (String?) -> Void) {
        
        let controller = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        for actionTitle in actions{
            let action:UIAlertAction = UIAlertAction(title: actionTitle, style: .default) { action in
                completion(controller.textFields?[0].text ?? "")
            }
            controller.addAction(action)
        }
        controller.addTextField { textField in
            if let value = text {
                textField.text = value
            }
            if let ph = placeholder {
                textField.placeholder = ph
            }
        }
        UIViewController.topViewController?.present(controller, animated: true, completion: nil)
    }
}


