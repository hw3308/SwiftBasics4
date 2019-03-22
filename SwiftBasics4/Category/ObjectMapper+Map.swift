//
//  ObjectMapper+Map.swift
//  SwiftBasics4
//
//  Created by 侯伟 on 17/1/11.
//  Copyright © 2017年 侯伟. All rights reserved.
//

import Foundation
import ObjectMapper

extension Map {
    func valueForKey<T>(_ key: String) -> T? {
        var value: T?
        value <- self[key]
        return value
    }
}
