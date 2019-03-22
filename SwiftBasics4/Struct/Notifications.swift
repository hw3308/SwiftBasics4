//
//  Notifications.swift
//  SwiftBasics
//
//  Created by 侯伟 on 17/1/11.
//  Copyright © 2017年 侯伟. All rights reserved.
//

import Foundation

public struct Notifications {
    
    public static let notificationCenter = NotificationCenter.default
    
    public static let reachabilityChanged = Proxy(name: "ReachabilityChanged")
    
    open class Proxy {
        
        fileprivate var name: String
        
         public init(name: String) {
            self.name = name
        }
        
        open func post(_ object: Any? = nil, userInfo: [AnyHashable: Any]? = nil) {
            Queue.async {
                notificationCenter.post(name: Notification.Name(rawValue: self.name), object: object, userInfo: userInfo)
            }
        }
        
        open func addObserver(_ observer: Any, selector: Selector, sender object: Any? = nil) {
            notificationCenter.addObserver(observer, selector: selector, name: NSNotification.Name(rawValue: name), object: object)
        }
        
        open func removeObserver(_ observer: Any, sender object: Any? = nil) {
            notificationCenter.removeObserver(observer, name: NSNotification.Name(rawValue: name), object: object)
        }
    }
    
    public static func removeObserver(_ observer: Any) {
        notificationCenter.removeObserver(observer)
    }
}
