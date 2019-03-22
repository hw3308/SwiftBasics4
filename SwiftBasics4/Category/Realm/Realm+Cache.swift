//
//  RealmManager.swift
//  SwiftBasics4
//
//  Created by houwei on 2019/3/4.
//  Copyright © 2019年 侯伟. All rights reserved.
//

import Foundation
import Realm
import RealmSwift

extension Realm{
    
    public static let filePath = (Realm.Configuration.defaultConfiguration.fileURL!.path as NSString).deletingLastPathComponent
    
    //MARK:share
    fileprivate static var _sharedRealm: Realm!
    
    public static var sharedRealm: Realm {
        if _sharedRealm == nil{
            _sharedRealm = try? Realm()
        }
        return _sharedRealm
    }
    
    public static func setSharedRealm(_ realm: Realm) {
        _sharedRealm = realm
    }
    
    //MAKR:user
    fileprivate static var _userRealm: Realm!
    
    public static var userRealm: Realm {
        if _userRealm == nil {
            return sharedRealm
        }
        return _userRealm
    }
    
    public static func setUserRealm(_ realm: Realm) {
        _userRealm = realm
    }
    
    public static func setUerRealm(_ name:String){
        
        let path = "\(filePath)/\(name).realm"
        if let url = URL.init(string: path){
            _userRealm = try? Realm.init(fileURL: url)
        }
    }
    public static func resetUserRealm() {
        _userRealm = nil
    }
}
