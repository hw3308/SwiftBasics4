//
//  WebViewController.swift
//  SwiftBasics4
//
//  Created by 侯伟 on 17/1/11.
//  Copyright © 2017年 侯伟. All rights reserved.
//

import Foundation
import WebKit

open class WebViewController: UIViewController {
    
    @IBOutlet open var webView: WebView!
    
    fileprivate var url:URL!
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        if webView == nil {
            webView = WebView(frame: view.bounds)
            view.addSubview(webView!)
        }
        
        webView.serviceDelegate = self
        
        if let _ = url {
            load(from: url)
        }
        
        self.webView.addObserver(self, forKeyPath: "title", options: .new, context: nil)
    }
    
    deinit {
        self.webView.removeObserver(self, forKeyPath: "title")
    }
    
    open func load(from url:URL) {
        if webView != nil {
            load(URLRequest(url: url))
        } else {
            self.url = url
        }
    }
    
    open func load(_ request: URLRequest) {
        _ = webView.loadRequest(request)
    }
    
    open class func open(urlString: String?) {
        guard let urlString = urlString else { return }
        open(url: URL(string: urlString))
    }
    
    open class func open(url: URL?) {
        guard let _ = url else { return }
        let controller = WebViewController()
        controller.load(from: url!)
        controller.hidesBottomBarWhenPushed = true
        UIViewController.showViewController(controller, animated: true)
    }
    
    override open func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "title" {
            self.title =  webView.webView.title
        }
    }
    
}
// MARK: - Navigation
extension WebViewController{
    
    open func close() {
        self.closeViewControllerAnimated(true)
    }
    
    open func back() {
        guard let webView = webView?.webView else { return }
        if webView.canGoBack {
            webView.goBack()
        } else {
            close()
        }
    }
    
    open func forward() {
        guard let webView = webView?.webView else { return }
        if webView.canGoForward {
            webView.goForward()
        }
    }
}


extension WebViewController:WebViewServiceDelegate{
    
    public func webView(_ webView: WebView, didCallService service: String, withStatus status: Bool, message: Any, options: WebView.EmbedService.Options) {
        
    }
    
    public func webView(_ webView: WebView, didCancelService service: String, withOptions options: WebView.EmbedService.Options) {
        
    }
}
