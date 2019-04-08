//
//  ApiError.swift
//  RHCT
//
//  Created by Cator Vee on 12/9/15.
//  Copyright © 2015 Ledong. All rights reserved.
//

import Foundation

//MAKR: 接口请求错误
enum ApiError: Error {
    
    //外部控制 错误码与错误对应 如果设置为空  则都处理成网络错误httpError
    public static var errorCodes = [(ApiError.apiError(message: ""),0),(ApiError.authorFilad,11)]
    
	case httpError(status: Int) ///网络请求失败
    
	case apiError(message: String) ///服务端返回失败
    
	case dataError  ///数据错误
    
    case authorFilad  ///用户认证失败
    
}
