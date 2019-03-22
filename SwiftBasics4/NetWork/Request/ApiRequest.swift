//
//  ApiRequest.swift
//  RHCT
//
//  Created by Cator Vee on 12/9/15.
//  Copyright © 2015 Ledong. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper
import AlamofireObjectMapper

 class ApiRequest{

    /// 默认选项
    fileprivate static let defaultOptions:Parameters = ["dataType":MIMEType.json,"quiet":true]
    
    ///请求对象
    fileprivate var request: DataRequest?
    
    ///请求参数
    public var params: Parameters = Parameters()
    
    ///请求选项
    public var options: Parameters = ApiRequest.defaultOptions
    
    ///动态请求 显示加载动画
    var activity: ApiRequest {
        options["quiet"] = false
        return self
    }
    
    ///请求设置
    let settings: ApiSettings
    
    let action:String
    
     init(action: String ,settings: ApiSettings) {
        self.settings = settings
        self.action = action
    }

    /// 调用前准备
    func prepare<T>( _ method: Alamofire.HTTPMethod,params: [String: Any]? = nil, callback: @escaping (_ response: ApiResponse<T>) -> Void)
        -> ApiRequest{
            if let _ = params{
                return updateParams(params).call(method, callback)
            }else{
                return call(method, callback)
            }
            
    }
    
    /// 设置请求参数
    func updateParams(_ params: [String: Any]?) -> ApiRequest {
        if let newParams = params {
            for (key, value) in newParams {
                self.params[key] = value
            }
        }
        return self
    }
    
    /// 设置请求选项
    func updateOptions(_ options: Parameters) -> ApiRequest {
        for (key, value) in options {
            self.options[key] = value
        }
        return self
    }
    
    
    /// 调用API请求
    fileprivate func call<T>(_ method: HTTPMethod, _ callback: @escaping (_ response: ApiResponse<T>) -> Void) -> ApiRequest {
        
        guard let url = URL(string: buidUrlString()) else {
            return self
        }
    
        let urlRequest = NSMutableURLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        urlRequest.cachePolicy = NetworkReachabilityManager()!.isReachable ?.reloadIgnoringCacheData:.returnCacheDataDontLoad
        
        let encoding: ParameterEncoding = (method != .get) ? JSONEncoding.default:URLEncoding.default

        let encoded = try? encoding.encode(urlRequest as! URLRequestConvertible , with: self.params)
        
        let manager = NetworkManager.defaultManager
        
        request = manager?.request(encoded!)
        
        #if DEBUG
            Log.info(self.request?.debugDescription)
        #endif
        
        self.startLoading()
        
        let dataType = self.options["dataType"] as! MIMEType
        switch dataType {
        case .json:
            request?.responseObject(queue: DispatchQueue.global(),  completionHandler: { (response:DataResponse<ApiResponse<T>>) in
                self.handleJSON(response, callback: callback)
            })
        default:
            Log.error("api: unsupported data type (\(dataType))")
            self.stopLoading()
            
        }
        return self
    }
    
    //请求结果处理
    fileprivate func handleJSON<T>(_ response:DataResponse<ApiResponse<T>>, callback: @escaping (_ response: ApiResponse<T>) -> Void){
        
        switch response.result{
        case .success(let value):
            
            value.rawData = response.data!
            

            if value.isOK {
                if let _ = self.options["cacheKey"] as? String {
                    
                }
                Log.info(value.rawString)
            } else {
                Log.error(value.errorMsg)
            }
            
        case .failure(_):
            
            let value = ApiResponse<T>()
            value.isOK = false
            
            if let statusCode = response.response?.statusCode {
                if statusCode >= 200 && statusCode < 400 {
                    value.error = ApiError.httpRequestError(status: (response.response?.statusCode)!)
                    Queue.async {
                        callback(value)
                    }
                    return
                }
            }
            value.error = ApiError.dataError
            Queue.async {
                callback(value)
            }
        }
    }
    

    public func uploadImage<T>(_ images : [String], fileName : String, params: [String : Any]?,_ callback: @escaping (_ response: ApiResponse<T>) -> Void){
        
        let timestamp = Int(Date().timeIntervalSince1970)
        let fieldName = "\(timestamp).jpeg"
        self.uploadImage(images,fileName:fileName,fieldName:fieldName,params:params,callback)
    }
    public func uploadImage<T>(_ images : [String], fileName : String, fieldName:String,params: [String : Any]!,_ callback: @escaping (_ response: ApiResponse<T>) -> Void){
        
    }

    /// 取消API请求
    func cancel() {
        request?.cancel()
    }

    // 生成URL字符串
    func buidUrlString() -> String {
        return "\(settings.baseURL())/\(action)"
    }
}

// MARK: - 载入动画

extension ApiRequest {
    
    fileprivate func startLoading() {
        
        if let quiet = self.options["quiet"] as? Bool, quiet {
            return
        }
        
        LoadingIndicator.shared.startLoading()
    }
    
    fileprivate func stopLoading() {
        
        if let quiet = self.options["quiet"] as? Bool, quiet {
            return
        }
        LoadingIndicator.shared.stopLoading()
    }
}

// MARK: - 标准HTTP Method调用
extension ApiRequest {

    /// 调用GET请求
    func get<T>(_ params: [String: Any]? = nil, callback: @escaping (_ response: ApiResponse<T>) -> Void) -> ApiRequest {
        return prepare(.get, params: params, callback: callback)
    }

    /// 调用POST请求
    func post<T>(_ params: [String: Any]? = nil,  callback: @escaping (_ response: ApiResponse<T>) -> Void) -> ApiRequest {
        return prepare(.post, params: params, callback: callback)
    }

    /// 调用PUT请求
    func put<T>(_ params: [String: Any]? = nil, callback: @escaping (_ response: ApiResponse<T>) -> Void) -> ApiRequest {
        return prepare(.put, params: params, callback: callback)
    }

    /// 调用DELETE请求
    func delete<T>(_ params: [String: Any]? = nil, callback: @escaping (_ response: ApiResponse<T>) -> Void) -> ApiRequest {
        return prepare(.delete, params: params, callback: callback)
    }

}

// MARK: - 其他接口请求

extension ApiRequest {

    /// 调用POST请求(提交JSON字符串)
    func post<T>(_ jsonString: String, callback: @escaping (_ response: ApiResponse<T>) -> Void) {
        
        guard let url = URL(string: buidUrlString()) else{
            return
        }

        let urlRequest = NSMutableURLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.cachePolicy = NetworkReachabilityManager()!.isReachable ?.reloadIgnoringCacheData:.returnCacheDataDontLoad
        urlRequest.httpBody = jsonString.data
        
        let encoding: ParameterEncoding = URLEncoding.default
        
        let encoded = try? encoding.encode(urlRequest as! URLRequestConvertible , with: self.params)
    
        request = NetworkManager.defaultManager.request(encoded!)
        
        let r = request?.responseObject { (response: DataResponse<ApiResponse<T>>) in
            self.handleJSON(response, callback: callback)
        }
        Log.info(r.debugDescription)
    }

}
