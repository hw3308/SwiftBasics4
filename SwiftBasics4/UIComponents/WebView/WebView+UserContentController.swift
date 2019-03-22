//
//  WebView+UserContentController.swift
//  SwiftBasics4
//
//  Created by 侯伟 on 17/1/11.
//  Copyright © 2017年 侯伟. All rights reserved.
//

import Foundation
import WebKit
import SwiftyJSON

extension WebView {
    
    open class UserContentController : WKUserContentController, WKScriptMessageHandler {
        
        let name = "__AHA_JSSDK"
        let methodKey = "__AHA__METHOD__NAME__"
        
        open var embedService: EmbedService!
        open weak var webView: WebView!
        
        override init() {
            super.init()
            self.embedService = EmbedService(userContentController: self)
            self.add(self, name: name)
        }
        
        required public init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        open func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
            if message.name == name {
                if let body = message.body as? String {
                    let options = body.json
                    if let methodName = options?[methodKey].string, !methodName.isEmpty {
                        embedService.process(methodName, options: options!)
                    }
                }
            }
        }
    }
}
