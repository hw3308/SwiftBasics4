//
//  UIColor+RGB.swift
//  SwiftBasics4
//
//  Created by 侯伟 on 17/1/11.
//  Copyright © 2017年 侯伟. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    
    public convenience init(r: UInt32, g: UInt32, b: UInt32, a: CGFloat = 1.0) {
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: a)
    }
    
    public convenience init(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat = 1.0) {
        self.init(red: r, green: g, blue: b, alpha: a)
    }
    
    public convenience init(rgb: UInt32) {
        self.init(rgba: rgb << 8 | 0xFF)
    }
    
    public convenience init(rgba: UInt32) {
        self.init(r: rgba >> 24, g: rgba >> 16 & 0xFF, b: rgba >> 8 & 0xFF, a: CGFloat(rgba & 0xFF) / 255)
    }
    
}


/// 黑色
public let blackColor:UIColor = UIColor(rgb: 0x333333)

/// 深灰
public let darkGreyColor:UIColor = UIColor(rgb: 0x666666)

/// 灰色
public let greyColor:UIColor = UIColor(rgb: 0x999999)

/// 浅灰
public let lightGreyColor:UIColor = UIColor(rgb: 0xcccccc)
