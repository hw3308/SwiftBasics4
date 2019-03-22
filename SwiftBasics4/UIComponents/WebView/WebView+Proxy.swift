//
//  WebView+Proxy.swift
//  SwiftBasics4
//
//  Created by 侯伟 on 17/1/11.
//  Copyright © 2017年 侯伟. All rights reserved.
//

import Foundation
import WebKit

extension WebView {
    
    // MARK: The properties of WKWebView
    
    public var canGoBack: Bool {
        return webView.canGoBack
    }
    public var canGoForward: Bool {
        return webView.canGoForward
    }
    public var title: String? {
        return webView.title
    }
    public var loading: Bool {
        return webView.isLoading
    }
    public var url: URL? {
        return webView.url
    }
    
    // MARK: - The methods of WKWebView
    
    public func reload() -> WKNavigation? {
        return webView.reload()
    }
    
    public func reloadFromOrigin() -> WKNavigation? {
        return webView.reloadFromOrigin()
    }
    
    public func loadRequest(_ request: URLRequest) -> WKNavigation? {
        return webView.load(request)
    }
    
    public func loadHTMLString(_ string: String, baseURL: Foundation.URL?) -> WKNavigation? {
        return webView.loadHTMLString(string, baseURL: baseURL)
    }
    
    public func stopLoading() {
        webView.stopLoading()
    }
    
    public func goBack() -> WKNavigation? {
        return webView.goBack()
    }
    
    public func goForward() -> WKNavigation? {
        return webView.goForward()
    }
    
    public func evaluateJavaScript(_ javaScriptString: String, completionHandler: ((AnyObject?, NSError?) -> Void)?) {
        webView.evaluateJavaScript(javaScriptString, completionHandler: completionHandler as! ((Any?, Error?) -> Void)?)
    }
}
