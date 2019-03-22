//
//  Queue.swift
//  SwiftBasics4
//
//  Created by houwei on 2019/2/28.
//  Copyright © 2019年 侯伟. All rights reserved.
//

import UIKit

struct Queue {
    /// 延迟执行代码
    public static func delay(_ seconds: UInt64, task: @escaping () -> Void) {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(Int64(seconds * NSEC_PER_SEC)) / Double(NSEC_PER_SEC), execute: task)
    }
    
    /// 异步执行代码块（先非主线程执行，再返回主线程执行）
    public static func async(_ backgroundTask: @escaping () -> AnyObject?, mainTask: @escaping (AnyObject?) -> Void) {
        DispatchQueue.global(qos: DispatchQoS.QoSClass.default).async {
            let result = backgroundTask()
            DispatchQueue.main.sync {
                mainTask(result)
            }
        }
    }
    
    /// 异步执行代码块（主线程执行）
    public static func async(_ mainTask: @escaping () -> Void) {
        DispatchQueue.main.async(execute: mainTask)
    }
    
    /// 顺序执行代码块（在队列中执行）
    public static func sync(_ task: () -> Void) {
        DispatchQueue(label: "com.hw.Queue", attributes: []).sync(execute: task)
    }
}

