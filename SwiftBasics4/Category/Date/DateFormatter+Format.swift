//
//  DateFormatter+Format.swift
//  SwiftBasics4
//
//  Created by mac on 17/2/28.
//  Copyright © 2017年 hw. All rights reserved.
//

import Foundation


extension DateFormatter {
    /// 初始化NSDateFormatter时，传递dataFormat属性值
    public convenience init(dateFormat: String) {
        self.init()
        self.dateFormat = dateFormat
    }
    
    public enum DateFormatString:String {
        
        case HMFormatString = "HH:mm"
        
        case DHFormatString = "dd HH"
        
        case MDFormatString = "MM:dd"
        
        case HMSFormatString = "HH:mm:ss"
        
        case YMDFormatString = "yyyy-MM-dd"
        
        case TimestampFormatString = "yyyy-MM-dd HH:mm:ss"
    }
}
