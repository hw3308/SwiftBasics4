//
//  WebView+NavigationDelegate.swift
//  SwiftBasics4
//
//  Created by 侯伟 on 17/1/11.
//  Copyright © 2017年 侯伟. All rights reserved.
//

import Foundation
import WebKit

extension WebView: WKNavigationDelegate {
    
    ///请求之前，决定是否要跳转:用户点击网页上的链接，需要打开新页面时，将先调用这个方法。
    public func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        guard let url = navigationAction.request.url else {
            decisionHandler(.cancel)
            return
        }
        let urlString = url.absoluteString
        if urlString.contains("//itunes.apple.com/") || !urlString.hasPrefix("//") && !urlString.hasPrefix("http:") && !urlString.hasPrefix("https:") {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url, options: [UIApplication.OpenExternalURLOptionsKey : Any](), completionHandler: nil)
            } else {
                UIApplication.shared.openURL(url)
            }
            decisionHandler(.cancel)
            return
        }
        
        if let _ = navigationDelegate ,navigationDelegate!.responds(to: Selector(("webView:decidePolicyFor:decisionHandler:"))){
            navigationDelegate?.webView?(webView, decidePolicyFor: navigationAction, decisionHandler: decisionHandler)
            return
        }
        
        decisionHandler(.allow)
    }
    ///接收到相应数据后，决定是否跳转
    public func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        
        if let _  = navigationDelegate{
            navigationDelegate?.webView?(webView, decidePolicyFor: navigationResponse, decisionHandler: decisionHandler)
            return
        }
            
        decisionHandler(.allow)
    }
    
    ///页面开始加载时调用
    public func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        loadingProgressBarHidden = false
        navigationDelegate?.webView?(webView, didStartProvisionalNavigation: navigation)
    }
    
    /// 主机地址被重定向时调用
    public func webView(_ webView: WKWebView, didReceiveServerRedirectForProvisionalNavigation navigation: WKNavigation!) {
        navigationDelegate?.webView?(webView, didReceiveServerRedirectForProvisionalNavigation: navigation)
    }
    /// 页面加载失败时调用
    public func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        loadingProgressBarHidden = true
        navigationDelegate?.webView?(webView, didFailProvisionalNavigation: navigation, withError: error)
    }
    /// 当内容开始返回时调用
    public func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        navigationDelegate?.webView?(webView, didCommit: navigation)
    }
    /// 页面加载完毕时调用
    public func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        loadingProgressBarHidden = true
        navigationDelegate?.webView?(webView, didFinish: navigation!)
    }
    
    ///跳转失败时调用
    public func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        navigationDelegate?.webView?(webView, didFail: navigation, withError: error)
    }
    
    /// 如果需要证书验证，与使用AFN进行HTTPS证书验证是一样的
    public func webView(_ webView: WKWebView, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        if navigationDelegate != nil && navigationDelegate!.responds(to: #selector(WKNavigationDelegate.webView(_:didReceive:completionHandler:))) {
            navigationDelegate!.webView?(webView, didReceive: challenge, completionHandler: completionHandler)
        } else {
            guard let hostName = webView.url?.host else {
                completionHandler(.cancelAuthenticationChallenge, nil);
                return
            }
            
            let authenticationMethod = challenge.protectionSpace.authenticationMethod
            if authenticationMethod == NSURLAuthenticationMethodDefault
                || authenticationMethod == NSURLAuthenticationMethodHTTPBasic
                || authenticationMethod == NSURLAuthenticationMethodHTTPDigest {
                let title = "身份认证"
                let message = "\(hostName)需要您的用户名和密码"
                let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
                alertController.addTextField {
                    $0.placeholder = "用户名"
                }
                alertController.addTextField {
                    $0.placeholder = "密码"
                    $0.isSecureTextEntry = true
                }
                alertController.addAction(UIAlertAction(title: "确定", style: .default, handler: { _ in
                    let username = alertController.textFields![0].text ?? ""
                    let password = alertController.textFields![1].text ?? ""
                    let credential = URLCredential(user: username, password: password, persistence: .none)
                    completionHandler(.useCredential, credential)
                }))
                alertController.addAction(UIAlertAction(title: "取消", style: .cancel, handler: { _ in
                    completionHandler(.cancelAuthenticationChallenge, nil)
                }))
                Queue.async {
                    UIViewController.topViewController?.present(alertController, animated: true, completion: nil)
                }
            } else if authenticationMethod == NSURLAuthenticationMethodServerTrust {
                completionHandler(.performDefaultHandling, nil)
            } else {
                completionHandler(.cancelAuthenticationChallenge, nil)
            }
        }
    }
    ///9.0才能使用，web内容处理中断时会触发
    @available(iOS 9.0, *)
    public func webViewWebContentProcessDidTerminate(_ webView: WKWebView) {
        navigationDelegate?.webViewWebContentProcessDidTerminate?(webView)
    }
}
