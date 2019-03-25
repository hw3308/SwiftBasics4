//
// Created by Cator Vee on 7/9/16.
// Copyright (c) 2016 侯伟. All rights reserved.
//

import Foundation
import ObjectMapper

class MappableArray<T: Mappable> : Mappable {

    var value: [T] = []

    required init?(map: Map) {
        if let val = map.currentValue as? [String:Any] {
            for item in val {
                let _map = Map(mappingType:.fromJSON, JSON: item)
                var obj = T(map:_map)
                obj?.mapping(map:_map)
                value.append(obj!)
            }
        }
    }

    func mapping(map: Map) {
        // nothing
        value <- map["value"]
    }
}
