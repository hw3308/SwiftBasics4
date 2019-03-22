//
//  NetworkManager.swift
//  SwiftBasics4
//
//  Created by 侯伟 on 17/1/11.
//  Copyright © 2017年 侯伟. All rights reserved.
//

import Foundation
import Alamofire
import Kingfisher

open class NetworkManager {
    
    public static var defaultManager: Alamofire.SessionManager!
    
    public static let sharedCookieStorage = HTTPCookieStorage.shared
    
    public static func initNetworkManager(sserverTrustPolicie serverTrustPolicies: [String: ServerTrustPolicy]? = nil) {
        
        SwiftURLCache.activate()
        
        var serverTrustPolicyManager: ServerTrustPolicyManager? = nil
        if let policies = serverTrustPolicies {
            serverTrustPolicyManager = ServerTrustPolicyManager(policies: policies)
        }
        
        // 初始化图片下载器
        let configuration = NetworkManager.defaultSessionConfiguration
        configuration.requestCachePolicy = .returnCacheDataElseLoad
//        let manager = Alamofire.SessionManager(configuration: configuration, serverTrustPolicyManager: serverTrustPolicyManager)
         //设置图片缓存
        let downloader = KingfisherManager.shared.downloader
        downloader.downloadTimeout = 5.0
        
        let cache = KingfisherManager.shared.cache
        cache.maxDiskCacheSize = 100 * 1024 * 1024
        cache.maxCachePeriodInSecond = 60 * 60 * 24 * 7
        cache.cleanExpiredDiskCache()
        
        downloader.sessionConfiguration = configuration
        
        // 初始化默认网络请求
        NetworkManager.defaultManager = Alamofire.SessionManager(
            configuration: NetworkManager.defaultSessionConfiguration,
            serverTrustPolicyManager: serverTrustPolicyManager
        )
    }
    
    static func removeAllCookies() {
        if let cookies = sharedCookieStorage.cookies {
            for cookie in cookies {
                sharedCookieStorage.deleteCookie(cookie)
            }
        }
    }
}

// MARK: - Default Session Configuration

extension NetworkManager {
    public static var defaultSessionConfiguration: URLSessionConfiguration {
        var headers = Alamofire.SessionManager.defaultHTTPHeaders
        headers["Cache-Control"] = "private"
        headers["User-Agent"] = WebView.userAgent
        
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 20 // 网络超时时间
        configuration.httpAdditionalHeaders = headers
        configuration.httpCookieStorage = sharedCookieStorage
        configuration.urlCache = Foundation.URLCache.shared
        
        return configuration
    }
}
