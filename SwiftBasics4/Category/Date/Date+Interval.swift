//
//  Date+Interval.swift
//  SwiftBasics4
//
//  Created by houwei on 2019/3/21.
//  Copyright © 2019年 侯伟. All rights reserved.
//

import Foundation


extension Date{
    
    public static func daysOffsetBetween(startDate:Date,endDate:Date) -> Int?{
        
        var gregorian = Calendar(identifier: .gregorian)
        gregorian.locale = Locale.current
        
        let comps = gregorian.dateComponents([.day], from: startDate, to: endDate)
        
        return comps.day;
    }
    
    public static func dateAfterMinutes(Minutes:Int) -> Date{
        let aTimeInterval:TimeInterval =  Date.timeIntervalSinceReferenceDate + Double(kMinute * Double(Minutes))
        return Date.init(timeIntervalSinceReferenceDate: aTimeInterval)
    }
    
    public static func dateBeforeMinutes(Minutes:Int) -> Date{
        let aTimeInterval:TimeInterval =  Date.timeIntervalSinceReferenceDate + Double(kMinute * Double(Minutes) * -1)
        return Date.init(timeIntervalSinceReferenceDate: aTimeInterval)
    }
    
    public static func dateAfterHours(hours:Int) -> Date{
        return dateAfterMinutes(Minutes: hours * 60)
    }
    
    public static func dateBeforeHours(hours:Int) -> Date{
        return dateAfterMinutes(Minutes: hours * 60 * -1)
    }
    
    public static func dateBeforeDays(days:Int) -> Date{
        return dateAfterHours(hours:days*24 * -1)
    }
    
    public static func dateAfterDyas(days:Int) -> Date{
        return dateAfterHours(hours:days*24)
    }
    
    public static func tomorrow() -> Date{
        return dateAfterDyas(days: 1)
    }
    
    public static func yesterday() -> Date{
        return dateAfterDyas(days: -1)
    }
    
    public func daysBetweenCurrentDateAndDate() ->Int {
        
        let dateSelf = Date.dateStandardFormatTimeZero(date: self)
        let timeInterval = dateSelf?.timeIntervalSince1970
        
        let dateNow =  Date.dateStandardFormatTimeZero(date: Date())
        let timeIntervalNow = dateNow?.timeIntervalSince1970
        
        let cha = timeInterval! - timeIntervalNow!
        
        let day = cha / kDaySeconds;
        
        return Int(day);
    }
    
    public func stringYearMonthDayCompareToday() -> String{
        
        let chaDay = self.daysBetweenCurrentDateAndDate()
        
        if chaDay == 0 {
            return "今天"
        }else if chaDay == 1{
            return "明天"
        }else if chaDay == 2{
            return "后天"
        }else if chaDay == -1{
            return "昨天"
        }else{
            return Date.dateMonthDay(date: self) ?? ""
        }
    }
}
