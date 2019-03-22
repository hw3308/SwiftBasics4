//
//  CacheManager.swift
//  SwiftBasics4
//
//  Created by 侯伟 on 17/1/11.
//  Copyright © 2017年 侯伟. All rights reserved.
//

import Foundation
import ObjectMapper
import Realm
import RealmSwift

// MARK: - CacheManager
open class CacheManager {
    
    public static var shared:CacheManager{
        return CacheManager(cachable: RealmCacheable(realm:Realm.sharedRealm))
    }
    
    public static var user:CacheManager {
        return CacheManager(cachable: RealmCacheable(realm:Realm.userRealm))
    }
    
    private let cachable: Cacheable
    
    public init(cachable: Cacheable) {
        self.cachable = cachable
    }
    
    // MARK: - Methods
    public func object<T: Mappable>(forKey key: String) -> T? {
        
        guard let content: String = cachable.string(forKey: key) else {
            return nil
        }
        return Mapper<T>().map(JSONString: content)
    }
    
    public func setObject<T: Mappable>(_ object: T, forKey key: String) {
        
        guard let jsonString = Mapper<T>().toJSONString(object) else {
            return
        }
        cachable.setString(jsonString, forKey: key)
    }
    
    public func remove(forKey key: String) {
        cachable.remove(forKey: key)
    }
    
    public func clear(){
        cachable.clear()
    }
}

// MARK: - Subscript
extension CacheManager{

    public subscript(key: String) -> CacheObject? {
        get {
            return cachable.object(forKey: key)
        }
        set {
            if let value = newValue {
                value.key = key
                cachable.setObject(value)
            }
        }
    }
    
    public subscript(stringkey: String) -> String? {
        get {
            return cachable.string(forKey: stringkey)
        }
        set {
            if let string = newValue {
                cachable.setString(string, forKey: stringkey)
            }
        }
    }
    
    public subscript(intkey: String) -> Int? {
        get {
            return cachable.string(forKey: intkey)?.integer
        }
        set {
            if let string = newValue?.string {
                cachable.setString(string, forKey: intkey)
            }
        }
    }
    
    public subscript(floatkey: String) -> Float? {
        get {
            return cachable.string(forKey: floatkey)?.float
        }
        set {
            if let string = newValue?.string {
                cachable.setString(string, forKey: floatkey)
            }
        }
    }
    
    public subscript(doublekey: String) -> Double? {
        get {
            return cachable.string(forKey: doublekey)?.double
        }
        set {
            if let string = newValue?.string {
                cachable.setString(string, forKey: doublekey)
            }
        }
    }
    
    public subscript(boolkey: String) -> Bool? {
        get {
            return cachable.string(forKey: boolkey)?.bool
        }
        set {
            if let string = newValue?.string {
                cachable.setString(string, forKey: boolkey)
            }
        }
    }
}
