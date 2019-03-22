//
//  Toast.swift
//  SwiftBasics4
//
//  Created by houwei on 2019/2/28.
//  Copyright © 2019年 侯伟. All rights reserved.
//

import UIKit

struct Toast {
    
    public static func toast(_ message: String?, in view: UIView? = nil, duration: TimeInterval? = nil, position: ToastPosition? = nil, title: String? = nil, image: UIImage? = nil, style: ToastStyle? = nil, completion: ((_ didTap: Bool) -> Void)? = nil) {
        guard let view = view ?? UIApplication.shared.keyWindow else { return }
        let manager = ToastManager.shared
        view.makeToast(message, duration: duration ?? manager.duration, position: position ?? manager.position, title: title, image: image, style: style, completion: completion)
    }
    
    public static func spin(in view: UIView?, at position: ToastPosition = .center) {
        guard let _ = view else {
            return
        }
        view?.makeToastActivity(position)
    }
    
    public static func spin(in view: UIView?, at position: CGPoint) {
        guard let _ = view else {
            return
        }
        view?.makeToastActivity(position)
    }
    
    public static func spin(in view: UIView?, stop: Bool) {
        guard let _ = view else {
            return
        }
        if stop {
            view?.hideToastActivity()
        } else {
            spin(in: view)
        }
    }
}

