//
//  CALayer+Shadow.swift
//  SwiftBasics4
//
//  Created by 侯伟 on 17/1/11.
//  Copyright © 2017年 侯伟. All rights reserved.
//

import Foundation
import UIKit

extension CALayer {
    
    ///设置边框
    public func border(color:UIColor,width:CGFloat = 1.0/UIScreen.main.scale){
        borderColor = color.cgColor
        borderWidth = width
    }
    
    ///设置阴影
    public func shadow(color:UIColor,opacity:Float,offset:CGSize,radius:Float){
        shadowColor = color.cgColor
        shadowOpacity = opacity
        shadowOffset = offset
        shadowRadius = CGFloat(radius)
        masksToBounds = false
    }
}
