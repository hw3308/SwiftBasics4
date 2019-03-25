//
//  Kingfisher+Settings.swift
//  SwiftBasics4
//
//  Created by houwei on 2019/3/25.
//  Copyright © 2019年 侯伟. All rights reserved.
//

import Foundation
import Kingfisher

extension KingfisherManager{
    
    public func config(){
        
        let downloader = KingfisherManager.shared.downloader
        downloader.downloadTimeout = 5.0
        downloader.sessionConfiguration = NetworkManager.defaultSessionConfiguration
        
        let cache = KingfisherManager.shared.cache
        cache.maxDiskCacheSize = 100 * 1024 * 1024
        cache.maxCachePeriodInSecond = kWeekSeconds
        
        cache.cleanExpiredDiskCache()
    }
    
}
