//
//  String+Digit.swift
//  SwiftBasics4
//
//  Created by houwei on 2019/3/21.
//  Copyright © 2019年 侯伟. All rights reserved.
//

import Foundation

// MARK: - Int

extension String {
    public var int: Int32 { return (self as NSString).intValue }
    public var integer: Int { return (self as NSString).integerValue }
}

extension Int {
    public var string: String { return String(self) }
}

// MARK: - Float

extension String {
    public var float: Float { return (self as NSString).floatValue }
}

extension Float {
    public var string: String { return String(self) }
}

// MARK: - Double

extension String {
    public var double: Double { return (self as NSString).doubleValue }
}

extension Double {
    public var string: String { return String(self) }
}

// MARK: - Bool

extension String {
    public var bool: Bool { return (self as NSString).boolValue }
}

extension Bool {
    public var string: String { return self ? "true" : "false" }
}
