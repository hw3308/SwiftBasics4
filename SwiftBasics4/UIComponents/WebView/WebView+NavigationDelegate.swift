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
    
    public func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        guard let url = navigationAction.request.url else {
            decisionHandler(.cancel)
            return
        }
        let urlString = url.absoluteString
        if urlString.contains("//itunes.apple.com/") || !urlString.hasPrefix("//") && !urlString.hasPrefix("http:") && !urlString.hasPrefix("https:") {
            UIApplication.shared.openURL(url)
            decisionHandler(.cancel)
        } else if navigationDelegate != nil//&& navigationDelegate!.responds(to: #selector(WKNavigationDelegate.webView(_:decidePolicyFor:decisionHandler:)))
        {
            navigationDelegate!.webView?(webView, decidePolicyFor: navigationAction, decisionHandler: decisionHandler)
        } else {
            decisionHandler(.allow)
        }
    }//#1
    
    public func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        if navigationDelegate != nil //&& navigationDelegate!.responds(to: #selector(WKNavigationDelegate.webView(_:decidePolicyFor:decisionHandler:)))
        {
            navigationDelegate!.webView?(webView, decidePolicyFor: navigationResponse, decisionHandler: decisionHandler)
        } else {
            decisionHandler(.allow)
        }
    }//#2
    
    public func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        Log.info("webview: \(webView.url!.absoluteString)")
        if !loadingProgressBarHidden {
            loadingProgressBar.isHidden = false
            loadingProgressBar.progress = 0.1
        }
        navigationDelegate?.webView?(webView, didStartProvisionalNavigation: navigation)
    }//#3
    
    public func webView(_ webView: WKWebView, didReceiveServerRedirectForProvisionalNavigation navigation: WKNavigation!) {
        navigationDelegate?.webView?(webView, didReceiveServerRedirectForProvisionalNavigation: navigation)
    }//#4
    
    public func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        Log.error("webview didFailProvisionalNavigation:\(error)")
        navigationDelegate?.webView?(webView, didFailProvisionalNavigation: navigation, withError: error)
    }//#5
    
    public func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        navigationDelegate?.webView?(webView, didCommit: navigation)
    }//6
    
    public func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        loadingProgressBar.isHidden = true
        loadingProgressBar.progress = 1
        navigationDelegate?.webView?(webView, didFinish: navigation!)
    }//7
    
    public func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        navigationDelegate?.webView?(webView, didFail: navigation, withError: error)
    }//8
    
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
    }//9
    
    @available(iOS 9.0, *)
    public func webViewWebContentProcessDidTerminate(_ webView: WKWebView) {
        navigationDelegate?.webViewWebContentProcessDidTerminate?(webView)
    }//10
    
    
    
    @available(iOS 10.0, *)
    public func webView(_ webView: WKWebView, shouldPreviewElement elementInfo: WKPreviewElementInfo) -> Bool {
        return true
    }
    
    public func webView(_ webView: WKWebView, commitPreviewingViewController previewingViewController: UIViewController) {

    }
    
}
