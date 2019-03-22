//
//  String+Range.swift
//  SwiftBasics4
//
//  Created by houwei on 2019/3/21.
//  Copyright © 2019年 侯伟. All rights reserved.
//

import Foundation

// MARK: Substring

extension String {
    public func substring(_ fromIndex: Int, _ toIndex: Int = Int.max) -> String? {
        let len = self.length
        var start: Int
        var end: Int
        if fromIndex < 0 {
            start = 0
            end = len + fromIndex
        } else {
            start = fromIndex
            if toIndex < 0 {
                end = len + toIndex
            } else {
                end = min(toIndex, len)
            }
        }
        
        if start > end {
            return nil
        }
        
        return self[start..<end]
    }
    
    public subscript(range: Range<Int>) -> String? {
        let len = self.length
        if range.lowerBound >= len || range.upperBound < 0 {
            return nil
        }
        
        let startIndex = self.index(self.startIndex, offsetBy: max(0, range.lowerBound))
        let endIndex = self.index(self.startIndex, offsetBy: min(len, range.upperBound))
        
        return String(self[startIndex..<endIndex])
    }
    
    
    public subscript(index: Int) -> Character? {
        if index < 0 || index >= self.length {
            return nil
        }
        return self[self.index(self.startIndex, offsetBy: index)]
    }
}
