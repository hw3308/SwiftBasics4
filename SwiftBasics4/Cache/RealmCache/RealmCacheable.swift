//
//  RealmCacheable.swift
//  SwiftBasics4
//
//  Created by 侯伟 on 17/1/11.
//  Copyright © 2017年 侯伟. All rights reserved.
//

import Foundation
import RealmSwift
import Realm

open class RealmCacheable: Cacheable {

    fileprivate var realm:Realm
    
    public init(realm:Realm){
        self.realm = realm
    }
    
    public func object(forKey key: String) -> CacheObject? {
        
        if let obj = realm.object(ofType: CacheObject.self, forPrimaryKey: key as AnyObject){
            return obj
        }
        return nil
    }
    
    open func setObject(_ value: CacheObject) {
        try! realm.write {
            realm.add(value, update: true)
        }
    }
    
    public func string(forKey key: String) -> String? {
        
        return object(forKey: key)?.value
    }
    
    public func setString(_ string: String, forKey key: String){
        let obj = CacheObject()
        obj.key = key
        obj.value = string
        setObject(obj)
    }
    
    public func remove(forKey key: String) {
        guard let obj = object(forKey: key) else { return }
        try! realm.write {
            realm.delete(obj)
            Log.info("RealmDB: remove cache \"\(key)\"")
        }
    }
    
    open func clear() {
        do {
            if !realm.isEmpty {
                try realm.write {
                    realm.delete(realm.objects(CacheObject.self))
                }
            }
            Log.info("RealmDB: clear")
        } catch let error as NSError  {
            Log.error("RealmDB: clear. \(error)")
        }
    }
}
