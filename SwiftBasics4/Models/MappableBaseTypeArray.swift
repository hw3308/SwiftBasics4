//
//  MappableBaseTypeArray.swift
//  grapefruit
//
//  Created by moon on 16/3/2.
//  Copyright © 2016年 Ledong. All rights reserved.
//

import Foundation
import ObjectMapper

class MappableBaseTypeArray<T> : Mappable {
    
    var value = [T]()
    
    required init?(map: Map) {
        if let val = map.currentValue as? [T] {
            for item in val {
                value.append(item)
            }
        }
    }
    
    func mapping(map: Map) {
        // nothing
    }
}
