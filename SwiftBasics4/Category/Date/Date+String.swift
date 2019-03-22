//
//  Date+String.swift
//  SwiftBasics4
//
//  Created by houwei on 2019/3/21.
//  Copyright © 2019年 侯伟. All rights reserved.
//

import Foundation

// MARK: - formatString
extension Date{
    
    var string:String{
        return stringYearMonthDayHourMinuteSecond
    }
    
    var stringHourMinute:String{
        return dateString(format: .HMFormatString)
    }
    
    var stringDayHour:String{
        return dateString(format: .DHFormatString)
    }
    
    var stringHourMinuteSecond:String{
        return dateString(format: .HMFormatString)
    }
    
    var stringMonthDay:String{
        return dateString(format: .MDFormatString)
    }
    
    var stringYearMonthDay:String{
        return dateString(format: .YMDFormatString)
    }
    
    var stringYearMonthDayHourMinuteSecond:String{
        return dateString(format: .TimestampFormatString)
    }
    
    public func string(formatString:String) -> String {
        let formatter = DateFormatter.init(dateFormat: formatString)
        return formatter.string(from: self)
    }
    
    public func dateString(format:DateFormatter.DateFormatString) -> String {
        let formatter = DateFormatter.init(dateFormat: format.rawValue)
        return formatter.string(from: self)
    }
    
    public static func dateStandardFormatTimeZero(date:Date) -> Date?{
        let timeStr = date.stringYearMonthDay.appending(" 00:00:00")
        
        return Date.dateFromString(dateString: timeStr)
    }
    public static func dateMonthDay(date:Date? = nil) -> String?{
        var d = date
        if d == nil{
            d = Date()
        }
        if d?.years == Date().years{
            return d?.string(formatString: "MM月dd日")
        }else{
            return d?.string(formatString: "yyyy年MM月dd日")
        }
    }
    
    public static func dateFromString(dateString:String) -> Date?{
        
        let formatter = DateFormatter(dateFormat: DateFormatter.DateFormatString.TimestampFormatString.rawValue)
        return formatter.date(from:dateString)
        
    }
    
    public static func dateFromString(string:String,format:String) -> Date?{
        let inputFormatter = DateFormatter(dateFormat: format)
        inputFormatter.locale = Locale.current
        return inputFormatter.date(from: string)
    }
}

extension Date{
    
    var stringHourMinuteWithPrefix:String{
        return stringHourMinute(enablePrefix: true)
    }
    
    var stringHourMinuteWithSuffix:String{
        return stringHourMinute(enableSuffix: true)
    }
    
    public func stringHourMinute(enablePrefix:Bool = false,enableSuffix:Bool = false) ->String{
    
        let formatter = DateFormatter()
        formatter.dateFormat = "H:mm"
        
        var timeStr = formatter.string(from: self)
        
        if enablePrefix{
            timeStr = String(format: "%@ %@", (self.hours >= 12 ? "下午" : "上午"),timeStr)
        }
        if enableSuffix{
            timeStr = String(format: "%@ %@", (self.hours >= 12 ? "PM" : "AM"),timeStr)
        }
        return timeStr
    }
}
