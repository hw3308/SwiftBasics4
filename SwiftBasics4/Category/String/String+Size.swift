//
//  String+Size.swift
//  SwiftBasics4
//
//  Created by houwei on 2019/3/21.
//  Copyright © 2019年 侯伟. All rights reserved.
//

import Foundation

// MARK: Get the size of the text

extension String {
    
    /// 计算制定字体大小的文字显示尺寸（系统默认字体）
    public func size(fontSize: CGFloat, width: CGFloat = CGFloat.greatestFiniteMagnitude) -> CGSize {
        return size(font: font(fontSize), width: width)
    }
    
    /// 计算制定字体的文字显示尺寸
    public func size(font: UIFont, width: CGFloat = CGFloat.greatestFiniteMagnitude) -> CGSize {
        let size = CGSize(width: width, height: CGFloat.greatestFiniteMagnitude)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineBreakMode = .byWordWrapping
        let attributes = [
            NSAttributedString.Key.font: font,
            NSAttributedString.Key.paragraphStyle: paragraphStyle.copy()
        ]
        return (self as NSString).boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: attributes, context: nil).size
    }
}
