//
//  RealmEntityManager.swift
//  SwiftBasics4
//
//  Created by 侯伟 on 17/1/11.
//  Copyright © 2017年 侯伟. All rights reserved.
//

import Foundation
import Realm
import RealmSwift

open class RealmEntityManager<T: Object> {
    
    open var realm: Realm
    
    public init(realm: Realm) {
        self.realm = realm
    }
    
    // MARK: - Query Entity
    open var objects: Results<T> {
        return realm.objects(T.self)
    }
    
    open func object(primaryKey key: AnyHashable) -> T? {
        return realm.object(ofType: T.self, forPrimaryKey: key)
    }
    
    open func query(_ predicateFormat: String, _ args: Any...) -> Results<T> {
        return objects.filter(predicateFormat, args)
    }
    
    open func query(_ predicate: NSPredicate) -> Results<T> {
        return objects.filter(predicate)
    }
    
    // MARK: - Create Entity
    open func create(_ value: T) -> T? {
        var entity: T?
        do {
            try realm.write { [weak realm] in
                entity = realm?.create(T.self, value: value, update: true)
            }
        } catch let error {
            Log.error("EntityManager: \(error)")
        }
        return entity
    }
    
    // MARK: - Save Entity
    open func save(_ object: T) {
        do {
            try realm.write { [weak realm] in
                realm?.add(object, update: true)
            }
        } catch let error {
            Log.error("EntityManager: \(error)")
        }
    }
    
    open func write(_ callback: () -> Void) {
        do {
            try realm.write(callback)
        } catch let error {
            Log.error("EntityManager: \(error)")
        }
    }
    
    // MARK: - Delete Entity
    open func delete(_ object: T) {
        do {
            try realm.write { [weak realm] in
                realm?.delete(object)
            }
        } catch let error {
            Log.error("EntityManager: \(error)")
        }
    }
    
    open func delete(_ objects: Results<T>) {
        do {
            try realm.write { [weak realm] in
                realm?.delete(objects)
            }
        } catch let error {
            Log.error("EntityManager: \(error)")
        }
    }
    
    open func delete(_ objects: List<T>) {
        do {
            try realm.write { [weak realm] in
                realm?.delete(objects)
            }
        } catch let error {
            Log.error("EntityManager: \(error)")
        }
    }
    
    open func delete<S: Sequence>(_ objects: S) where S.Iterator.Element: Object {
        do {
            try realm.write { [weak realm] in
                realm?.delete(objects)
            }
        } catch let error {
            Log.error("EntityManager: \(error)")
        }
    }
    
    open func delete(_ predicateFormat: String, _ args: Any...) {
        delete(objects.filter(predicateFormat, args))
    }
    
    open func delete(_ predicate: NSPredicate) {
        delete(objects.filter(predicate))
    }
    
    open func delete(primaryKey key: AnyHashable) {
        if let object = object(primaryKey: key) {
            delete(object)
        }
    }
    
    open func deleteAll() {
        do {
            try realm.write { [objects, weak realm] in
                realm?.delete(objects)
            }
        } catch let error as NSError {
            Log.error("EntityManager: \(error)")
        }
    }
}
