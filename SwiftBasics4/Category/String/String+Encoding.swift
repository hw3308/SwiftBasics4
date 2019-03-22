//
//  String+Encoding.swift
//  SwiftBasics4
//
//  Created by houwei on 2019/3/21.
//  Copyright © 2019年 侯伟. All rights reserved.
//

import Foundation

// MARK: - NSData

extension Data {
    /// 返回UTF8字符串
    public var string: String {
        return String(data: self, encoding: String.Encoding.utf8) ?? ""
    }
}

extension String {
    /// 返回UTF8字符集的NSData对象
    public var data: Data {
        return self.data(using: String.Encoding.utf8, allowLossyConversion: false)!
    }
}

// MARK: URL encode/decode

extension String {
    /// URL编码
    public var urlEncoded: String {
        return self.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlHostAllowed) ?? self
    }
    
    public var urlEncodingWithQueryAllowedCharacters: String {
        return self.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) ?? self
    }
    
    /// URL解码
    public var urlDecoded: String {
        return self.removingPercentEncoding ?? self
    }
}



// MARK: Base64

extension String {
    /// Base64编码
    public var base64Encoded: String {
        return data.base64EncodedString(options: [])
    }
    
    /// Base64解码
    public var base64Decoded: String {
        return Data(base64Encoded: self, options: [])?.string ?? ""
    }
}
