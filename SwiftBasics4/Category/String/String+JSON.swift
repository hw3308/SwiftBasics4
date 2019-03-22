//
//  String+JSON.swift
//  SwiftBasics4
//
//  Created by houwei on 2019/3/21.
//  Copyright © 2019年 侯伟. All rights reserved.
//

import Foundation
import SwiftyJSON

// MARK: - JSON

extension String {
    /// String to JSON
    public var json: JSON? { return try? JSON(data: self.data) }
}

extension JSON {
    /// JSON to String
    public var jsonString: String { return rawString(String.Encoding.utf8, options: JSONSerialization.WritingOptions()) ?? "" }
}
