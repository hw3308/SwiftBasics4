//
//  MIMEType.swift
//  SwiftBasics4
//
//  Created by 侯伟 on 17/1/11.
//  Copyright © 2017年 侯伟. All rights reserved.
//

import Foundation

public enum MIMEType: String {
    case json = "application/json"
    case html = "text/xml"
    case xml = "text/html"
    case text = "text/plain"
    case unknown = "application/octet-stream"
    
    public var string: String {
        return self.rawValue
    }
    
    public static func fromString(_ mime: String) -> MIMEType {
        let all: [MIMEType] = [.json, .html, .xml, .text]
        for item in all {
            if mime == item.rawValue {
                return item
            }
        }
        return .unknown
    }
    
}
