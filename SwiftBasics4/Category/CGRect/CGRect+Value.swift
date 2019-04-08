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
        set{ self.origin.x = newValue }
        
        get{ return origin.x }
    }
    
    public var y:CGFloat{
        
        set{ self.origin.y = newValue }
        
        get{ return origin.y}
    }
    
    public var width:CGFloat{
        
        set{ self.size.width = newValue}
        
        get{ return size.width }
    }
    
    public var height:CGFloat{
        
        set{ self.size.height = newValue}
        
        get{ return size.height}
    }
}
