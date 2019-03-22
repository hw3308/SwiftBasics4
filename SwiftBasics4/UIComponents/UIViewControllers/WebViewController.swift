//
//  WebViewController.swift
//  SwiftBasics4
//
//  Created by 侯伟 on 17/1/11.
//  Copyright © 2017年 侯伟. All rights reserved.
//

import Foundation

open class WebViewController: UIViewController {
    @IBOutlet open var webView: WebView!
    
    fileprivate var url:URL!
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        
        if webView == nil {
            webView = WebView(frame: view.bounds)
            view.addSubview(webView!)
        }
        
        if let _ = url {
            load(from: url)
            self.url = nil
        }
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
    
    // MARK: - Navigation
    
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

extension WebViewController {
    @objc open class func open(urlString: String?) {
        guard let urlString = urlString else { return }
        open(url: URL(string: urlString))
    }
    
    @objc open class func open(url: URL?) {
        guard let _ = url else { return }
        let controller = WebViewController()
        controller.load(from: url!)
        controller.hidesBottomBarWhenPushed = true
        UIViewController.showViewController(controller, animated: true)
    }
}
