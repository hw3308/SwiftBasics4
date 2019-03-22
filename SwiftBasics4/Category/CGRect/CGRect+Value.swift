//
//  CGRect+Extension.swift
//  SwiftBasics4
//
//  Created by 侯伟 on 17/1/11.
//  Copyright © 2017年 侯伟. All rights reserved.
//

import Foundation
import UIKit

extension CGRect {
    
    public init(origin:CGPoint,size:CGSize){
        self.init(x: origin.x, y: origin.y, width: size.width, height: size.height)
    }
    
    public var center: CGPoint {
        return CGPoint(x: self.midX, y: self.midY)
    }
    
    public var x:CGFloat{
        return origin.x
    }
    
    public var y:CGFloat{
        return origin.y
    }
    
    public var width:CGFloat{
        return size.width
    }
    
    public var height:CGFloat{
        return size.height
    }
}
