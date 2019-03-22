//
//  String+Extension.swift
//  SwiftBasics4
//
//  Created by 侯伟 on 17/1/11.
//  Copyright © 2017年 侯伟. All rights reserved.
//

import Foundation


// MARK: Length
extension String {
    /// 字符串长度
    public var length: Int { return self.count }
}

// MARK: Trim

extension String {
    /// 删除前后空白符（包含空格、Tab、回车、换行符）
    public var trimmed: String {
        return self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }
}

// MARK: Localized String

extension String {
    public var localizedString: String {
        return NSLocalizedString(self, comment: "")
    }
}






