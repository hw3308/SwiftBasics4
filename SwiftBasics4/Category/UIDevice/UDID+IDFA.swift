//
//  UDID.swift
//  SwiftBasics4
//
//  Created by 侯伟 on 17/1/11.
//  Copyright © 2017年 侯伟. All rights reserved.
//

import Foundation
import AdSupport
import KeychainSwift

public struct UDID {
    
    /// UUID 系统重装后改变
    public static var UUIDString: String {
        return UUID().uuidString.replacingOccurrences(of: "-", with: "")
    }
    
    /// UDID 设备的唯一设备识别符
    public static var UDIDString: String {
        let keychain = KeychainSwift()
        if let udid = keychain.get("COMMON_UDID") {
            return udid
        }
        let udid = UIDevice.current.identifierForVendor!.uuidString.replacingOccurrences(of: "-", with: "")
        keychain.set(udid, forKey: "COMMON_UDID")
        return udid
    }
    
    /// IDFA 广告标识符
    public static var IDFAString: String {
        return ASIdentifierManager.shared().advertisingIdentifier.uuidString.replacingOccurrences(of: "-", with: "")
    }
    
    /// IDFV 应用加设备绑定产生的标识符
    public static var IDFVString: String {
        return UIDevice.current.identifierForVendor!.uuidString.replacingOccurrences(of: "-", with: "")
    }
    
}
