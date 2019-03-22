//
//  UIImage+Extension.swift
//  SwiftBasics4
//
//  Created by 侯伟 on 17/1/11.
//  Copyright © 2017年 侯伟. All rights reserved.
//

import Foundation
import UIKit
// MARK: Data

extension UIImage {
    public var data: Data? {
        switch imageType {
        case .jpeg:
            return self.jpegData(compressionQuality:1.0)
        case .png:
            return self.pngData()
        default:
            return nil
        }
    }
}

// MARK: Content Type

extension UIImage {
    
    fileprivate struct AssociatedKey {
        static var imageType: Int = 0
    }
    
    public enum ImageType: Int {
        
        case unknown = 0, png, jpeg, gif, tiff, webp
        
        public var type: String {
            switch self {
            case .jpeg: return "image/jpeg"
            case .png:  return "image/png"
            case .gif:  return "image/gif"
            case .tiff: return "image/tiff"
            case .webp: return "image/webp"
            default:    return ""
            }
        }
        public var suffix: String {
            switch self {
            case .jpeg: return ".jpg"
            case .png:  return ".png"
            case .gif:  return ".gif"
            case .tiff: return ".tiff"
            case .webp: return ".webp"
            default:    return ""
            }
        }
        
        public static func imageType(type: String?) -> ImageType {
            guard let mime = type else { return .unknown }
            switch mime {
            case "image/jpeg": return .jpeg
            case "image/png":  return .png
            case "image/gif":  return .gif
            case "image/tiff": return .tiff
            case "image/webp": return .webp
            default:           return .unknown
            }
        }
        
        public static func typeWithImageData(_ imageData: Data?) -> ImageType {
            guard let data = imageData else { return .unknown }
            
            var c = [UInt32](repeating: 0, count: 1)
            (data as NSData).getBytes(&c, length: 1)
            switch (c[0]) {
            case 0xFF:
                return .jpeg
            case 0x89:
                return .png
            case 0x47:
                return .gif
            case 0x49, 0x4D:
                return .tiff
            case 0x52: // R as RIFF for WEBP
                if data.count >= 12 {
                    if let type = String(data: data.subdata(in: data.startIndex..<data.startIndex.advanced(by: 12)), encoding: String.Encoding.ascii) {
                        if type.hasPrefix("RIFF") && type.hasSuffix("WEBP") {
                            return .webp
                        }
                    }
                }
            default:
                break
            }
            return .unknown
        }
    }
    
    convenience init?(data: Data, imageType: ImageType) {
        self.init(data: data)
        self.imageType = imageType
    }
    
    public var imageType: ImageType {
        get {
            let value = objc_getAssociatedObject(self, &AssociatedKey.imageType) as? Int ?? 0
            if value == 0 {
                var result: ImageType
                if let _ = self.jpegData(compressionQuality:1.0) {
                    result = .jpeg
                } else if let _ = self.pngData() {
                    result = .png
                } else {
                    result = .unknown
                }
                objc_setAssociatedObject(self, &AssociatedKey.imageType, result.rawValue, .OBJC_ASSOCIATION_RETAIN)
                return result
            }
            return ImageType(rawValue: value) ?? .unknown
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKey.imageType, newValue.rawValue, .OBJC_ASSOCIATION_RETAIN)
        }
    }
}
