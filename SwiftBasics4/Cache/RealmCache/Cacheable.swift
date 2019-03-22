//
//  Cacheable.swift
//  SwiftBasics4
//
//  Created by houwei on 2019/3/4.
//  Copyright © 2019年 侯伟. All rights reserved.
//

import Foundation

// MARK: - Cachable
public protocol Cacheable {
    
    func object(forKey key: String) -> CacheObject?
    
    func setObject(_ objct: CacheObject)
    
    func string(forKey key: String) -> String?
    
    func setString(_ string: String, forKey key: String)
    
    func remove(forKey key: String)
    
    func clear()
}
