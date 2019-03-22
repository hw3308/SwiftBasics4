//
//  CacheObject.swift
//  SwiftBasics4
//
//  Created by mac on 17/2/28.
//  Copyright © 2017年 hw. All rights reserved.
//

import Foundation
import RealmSwift

// MARK: - CacheObject
open class CacheObject: Object {
    
    @objc dynamic var key: String?
    
    @objc dynamic var value: String?
    
    @objc dynamic var expires: Double = 0.0

    var isValid: Bool {
        return self.expires > Date.timeIntervalSinceReferenceDate
    }
    
    // 主键
    override open class func primaryKey() -> String? {
        return "key"
    }
}
