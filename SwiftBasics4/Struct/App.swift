//
//  App.swift
//  SwiftBasics
//
//  Created by 侯伟 on 17/1/11.
//  Copyright © 2017年 侯伟. All rights reserved.
//

import Foundation

// 正则表达式：手机号
let REGEXP_MOBILES = "^(1[3-9][0-9])\\d{8}$"
//验证码 正则表达式
let REGEXT_VERCODE_4 = "^\\d{4}$"
let REGEXT_VERCODE_6 = "^\\d{6}$"
//邮箱正则
let REGEXP_EMAIL : String = "\\w+([-+.]\\w+)*@\\w+([-.]\\w+)*\\.\\w+([-.]\\w+)*"
//URL 正则
let REGEXP_URL : String = "http(s)?:\\/\\/([\\w-]+\\.)+[\\w-]+(\\/[\\w- .\\/?%&=]*)?"


public struct App {
    
    public enum RunMode {
        case debug, release
    }
    
    public static var runMode: RunMode = .debug
    
    public static var bundle: Bundle = Bundle.main
    
    /// 版本
    public static var version: String {
        return bundle.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String ?? ""
    }
    
    /// 内部版本
    public static var buildNub: Int {
        return Int(bundle.object(forInfoDictionaryKey: "CFBundleVersion") as? String ?? "0") ?? 0
    }
    
    /// 语言
    public static var language: String {
        return bundle.preferredLocalizations.first ?? ""
    }
    
    /// 名称
    public static var name:String{
        return bundle.object(forInfoDictionaryKey: "CFBundleDisplayName") as? String ?? ""
    }
}
