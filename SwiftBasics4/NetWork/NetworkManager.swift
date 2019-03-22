//
//  NetworkManager.swift
//  SwiftBasics4
//
//  Created by 侯伟 on 17/1/11.
//  Copyright © 2017年 侯伟. All rights reserved.
//

import Foundation
import Alamofire

open class NetworkManager {
    
    public static var defaultManager: SessionManager!
    
    public static let sharedCookieStorage = HTTPCookieStorage.shared
    
    public static var defaultSessionConfiguration:URLSessionConfiguration = URLSessionConfiguration.default
    

    //MARK: 初始化网络请求 默认JSON
    public static func initNetworkManager(serverTrustPolicie serverTrustPolicies: [String: ServerTrustPolicy]? = nil) {
        
        SwiftURLCache.activate()
        
        ///安全策略
        var serverTrustPolicyManager: ServerTrustPolicyManager? = nil
        if let policies = serverTrustPolicies {
            serverTrustPolicyManager = ServerTrustPolicyManager(policies: policies)
        }
        
        defaultSessionConfiguration.timeoutIntervalForRequest = 10
        defaultSessionConfiguration.httpAdditionalHeaders = Alamofire.SessionManager.defaultHTTPHeaders
        defaultSessionConfiguration.httpCookieStorage = sharedCookieStorage
        ///地址
        defaultSessionConfiguration.urlCache = URLCache.shared
        ///缓存策略
        defaultSessionConfiguration.requestCachePolicy = .returnCacheDataElseLoad
        
        defaultManager = Alamofire.SessionManager(configuration: NetworkManager.defaultSessionConfiguration, serverTrustPolicyManager: serverTrustPolicyManager)
    }
    
    static func removeAllCookies() {
        if let cookies = sharedCookieStorage.cookies {
            for cookie in cookies {
                sharedCookieStorage.deleteCookie(cookie)
            }
        }
    }
}
