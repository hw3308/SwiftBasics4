//
//  ApiResponse.swift
//  RHCT
//
//  Created by Cator Vee on 12/9/15.
//  Copyright © 2015 Ledong. All rights reserved.
//

import Foundation
import ObjectMapper
import SwiftyJSON

class ApiResponse<T: Mappable>:Mappable {
	
    ///原始值
    var rawData: Data!
    
    ///将原始值转换成的字符串
    var rawString: String! {
        return String(data: rawData, encoding: String.Encoding.utf8)
    }
    
    ///返回的模型数据
    var data: T?
    /// 状态码
    var code:Int = 0
    /// 错误信息
    var message: String?
    /// 当前服务端时间戳
    var timestamp:TimeInterval?
    
    //请求是否成功
    var isOK: Bool{
        return code == 0
    }
	
    //错误
	var error: ApiError?
    
	init() {

	}
	
	required init?(map: Map) {

	}
	
	func mapping(map: Map) {
        
        code <- map["code"]
        
        message <- map["message"]
        
		if isOK {
			let value = map.currentValue
            
            if value is String || value is Bool || value is Int || value is Array<Any> {
                data = T(map:map)
            }else{
                data <- map["data"]
            }
		} else {
			error = ApiError.apiError(message: message ?? "")
		}
	}
    
	func success(_ callback: (_ data: T?) -> Void) -> ApiResponse {
		guard isOK else { return self }
		callback(data)
        return self
	}
	
	func failure(_ callback: (_ error: ApiError) -> Void) -> ApiResponse {
        
		guard !isOK else { return self }
        
		if let error = self.error {
			callback(error)
		} else if data == nil {
			callback(ApiError.dataError)
		}
        return self
	}
	
	func failureDefault() -> ApiResponse {
        let res = self.failure { (error) in
            switch error{
            case .apiError(let message):
                if !message.isEmpty{
                    Toast.toast(message)
                }else{
                    Toast.toast("请求失败")
                }
            case .dataError, .httpError(_):
                Toast.toast("网络不给力")
            case .authorFilad:
                Toast.toast("请先登录")
            }
        }
		return res
	}
}
