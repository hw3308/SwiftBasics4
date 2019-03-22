//
//  Date+Calendar
//  SwiftBasics4
//
//  Created by 侯伟 on 17/1/11.
//  Copyright © 2017年 侯伟. All rights reserved.
//

import Foundation


let kMinute = 60.0
let kHour = kMinute * 60
let kDaySeconds = kHour * 24
let kDayMinutes = kMinute * 24
let kWeek = kDayMinutes * 7
let kMonth = kDayMinutes * 31
let kYear = kDayMinutes * 365


// MARK: Format
extension Date {
    
    /// 当前日历
    var currentCalendar: NSCalendar {
        return NSCalendar.current as NSCalendar
    }
    
    /// 单位
    var calendarUnit: NSCalendar.Unit {
        return ([.year, .month, .day, .weekOfMonth, .weekday, .day, .hour, .minute, .second])
    }
    /// 获取NSDateComponents，包含：年 月 日 时 分 秒 周
    var components: NSDateComponents {
        return currentCalendar.components(calendarUnit, from: self) as NSDateComponents
    }
    
    /// 秒
    var seconds: Int {
        return components.second
    }
    
    /// 分
    var minutes: Int {
        return components.minute
    }
    
    /// 小时
    var hours: Int {
        return components.hour
    }
    
    /// 天
    var days:Int{
        return components.day;
    }
    
    /// 月
    var months:Int{
        return components.month
    }
    
    /// 年
    var years:Int{
        return components.day
    }
    
    /// 星期几
    var weekday:Int{
        return components.weekday;
    }
    
    /// 第几周
    var weekYear:Int{
        return components.weekOfYear;
    }
    
    var daysUntilNow: NSNumber {
        let interval = NSDate().timeIntervalSince(self)
        let days = interval / kDaySeconds
        return NSNumber(value: days)
    }
    
    var midhight: NSDate {
        let calendar = currentCalendar
        let components: NSCalendar.Unit = [.day, .month, .year]
        let comps = calendar.components(components, from: self)
        return calendar.date(from: comps)! as NSDate
    }
    
    func dateSinceMidnightByAddingTimeInterval(timeInterval: TimeInterval) -> NSDate {
        let midnight = self.midhight
        return midnight.addingTimeInterval(timeInterval)
    }
}


extension Date{
    
    public static func date(year:Int,month:Int,day:Int,hour:Int,minute:Int,second:Int) -> Date?{
        
        let gregorian = Calendar(identifier: .gregorian)
        let timeZone = NSTimeZone.system
        var dateComps = DateComponents()
        dateComps.timeZone = timeZone
        dateComps.calendar = gregorian
        dateComps.year = year
        dateComps.month = month
        dateComps.day = day
        dateComps.hour = hour
        dateComps.minute = minute
        dateComps.second = second
        
        return dateComps.date;
    }
    
    public static func date(hour:Int,minute:Int) -> Date? {
        let calendar = Calendar(identifier: .gregorian)
        var dateComps = calendar.dateComponents([.year,.month,.day], from: Date())
        dateComps.hour = hour
        dateComps.minute = minute
        
        return calendar.date(from: dateComps)
    }
}



