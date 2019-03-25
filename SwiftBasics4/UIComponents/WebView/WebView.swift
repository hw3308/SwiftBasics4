//
//  WebView.swift
//  SwiftBasics4
//
//  Created by 侯伟 on 17/1/11.
//  Copyright © 2017年 侯伟. All rights reserved.
//

import Foundation
import WebKit

open class WebView: UIView {
    
    // MARK:- statics 用户代理信息
    fileprivate static var _userAgent: String!
    
    public static var userAgent: String {
        if _userAgent == nil {
            _userAgent = UIWebView().stringByEvaluatingJavaScript(from: "navigator.userAgent") ?? ""
        }
        let ua = "Agent/\(_userAgent!) Version/\(App.version) Language/\(App.language)"
        UserDefaults.standard.register(defaults: ["UserAgent": ua])
        return ua
    }
    
    public static var defaultProcessPool = WKProcessPool()
    
    public static var defaultConfiguration: WKWebViewConfiguration {
        
        let config = WKWebViewConfiguration()
        
        config.processPool = defaultProcessPool
        config.userContentController = UserContentController()
        config.allowsInlineMediaPlayback = true
        
        if #available(iOS 9.0, *) {
            config.websiteDataStore = WKWebsiteDataStore.default()
            config.requiresUserActionForMediaPlayback = false
        } else {
            config.mediaPlaybackRequiresUserAction = false
        }
        return config
    }
    
    
    // MARK: webView
    open var webView: WKWebView!
    
    // MARK: properties
    open var loadingProgressBar = UIProgressView()
    
    open var loadingProgressBarHidden: Bool = false {
        didSet {
            loadingProgressBar.isHidden = loadingProgressBarHidden
        }
    }
    
    // MARK: Delegate
    open weak var serviceDelegate: WebViewServiceDelegate?
    open weak var navigationDelegate: WKNavigationDelegate?
    open weak var UIDelegate: WKUIDelegate?
    
    // MARK: - init

    convenience init() {
        self.init(frame: CGRect.zero, configuration: WebView.defaultConfiguration)
    }
    
    override convenience init(frame: CGRect) {
        self.init(frame: frame, configuration: WebView.defaultConfiguration)
    }
    
    public init(frame: CGRect, configuration: WKWebViewConfiguration) {
        super.init(frame: frame)
        self.setup(configuration)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setup(WebView.defaultConfiguration)
    }
    
    open override func awakeFromNib() {
        super.awakeFromNib()
        self.setup(WebView.defaultConfiguration)
    }
    
    fileprivate func setup(_ config: WKWebViewConfiguration) {
        
        /// Setup Loading ProgressBar
        
        loadingProgressBar.autoresizingMask = [.flexibleWidth]
        self.addSubview(loadingProgressBar)
        loadingProgressBar.frame = CGRect.init(x: 0, y: 0, width: self.frame.width, height: 1.0)
 
        // Setup WebView
        let frame = CGRect.init(x: 0, y: 1.0, width: self.frame.width, height: self.frame.height-1.0)
        webView = WKWebView(frame: frame, configuration: config)
        webView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(webView)
        
        if #available(iOS 11, *){
            webView.scrollView.contentInsetAdjustmentBehavior =  .never
        }

        // Setup User Agent
        if #available(iOS 9.0, *) {
            webView.customUserAgent = WebView.userAgent
        }
        
        // Setup User Content Controller
        if let userContentController = webView.configuration.userContentController as? UserContentController {
            userContentController.webView = self
        }
        
        // Setup Navigation Delegate
        webView.navigationDelegate = self
        
        // Setup UI Delegate
        webView.uiDelegate = self
        
        webView.addObserver(self, forKeyPath: "estimatedProgress", options: .new, context: nil)
    }
    
    deinit {
        webView.removeObserver(self, forKeyPath: "estimatedProgress")
    }
    
    
    // MARK: - Observe Value For KeyPath
    override open func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey:Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            self.loadingProgressBar.progress = Float(0.1 + self.webView.estimatedProgress * 0.9)
        }
    }
}
