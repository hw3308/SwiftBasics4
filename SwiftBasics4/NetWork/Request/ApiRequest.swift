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
    
    fileprivate func codingURLRequest(_ url: URL, method: HTTPMethod ,params: Parameters?,  timeout:TimeInterval = 10) -> URLRequest?{
        
        let cachePolicy:NSURLRequest.CachePolicy = NetworkReachabilityManager()!.isReachable ?.reloadIgnoringCacheData:.returnCacheDataDontLoad
        
        var urlRequest = URLRequest.init(url: url, cachePolicy: cachePolicy, timeoutInterval: timeout)
        urlRequest.httpMethod = method.rawValue
        
        let encodingMode: ParameterEncoding = (method != .get) ? JSONEncoding.default:URLEncoding.default
        
        let re = try? encodingMode.encode(urlRequest , with: params)
        
        return re
    }
    
    /// 调用API请求
    fileprivate func call<T>(_ method: HTTPMethod, _ callback: @escaping (_ response: ApiResponse<T>) -> Void) -> ApiRequest {
        
        guard let url = URL(string: buidUrlString()) else {
            return self
        }
    
        let re = codingURLRequest(url, method: method, params: self.params)
    
        self.request = NetworkManager.defaultManager?.request(re!)
        
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
            self.stopLoading()
            
        }
        return self
    }
    
    //请求结果处理
    fileprivate func handleJSON<T>(_ response:DataResponse<ApiResponse<T>>, callback: @escaping (_ response: ApiResponse<T>) -> Void){
        
        self.stopLoading()
        
        switch response.result{
        case .success(let value):
    
            value.rawData = response.data!
            if value.isOK {
                if let _ = self.options["cacheKey"] as? String {
                    
                }
                Log.info(value.rawString)
            } else {
                Log.error(value.message)
            }
            Queue.async {
                callback(value)
            }
            
        case .failure(_):
            let value = ApiResponse<T>()
            if let statusCode = response.response?.statusCode {
                value.code = statusCode
                if statusCode >= 200 && statusCode < 400 {
                    value.error = ApiError.httpError(status: (response.response?.statusCode)!)
                    return
                }
            }
            value.code = -1
            value.error = ApiError.dataError
            Queue.async {
                callback(value)
            }
        }
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

        let cachePolicy:NSURLRequest.CachePolicy = NetworkReachabilityManager()!.isReachable ?.reloadIgnoringCacheData:.returnCacheDataDontLoad
        
        var urlRequest = URLRequest.init(url: url, cachePolicy: cachePolicy, timeoutInterval: 10.0)
        urlRequest.httpMethod = HTTPMethod.post.rawValue
        urlRequest.httpBody = jsonString.data
        
        let encoding: ParameterEncoding = URLEncoding.default
        
        let re = try? encoding.encode(urlRequest, with: self.params)
    
        self.request = NetworkManager.defaultManager.request(re!)
        
        startLoading()
        let r = request?.responseObject { (response: DataResponse<ApiResponse<T>>) in
            self.stopLoading()
            self.handleJSON(response, callback: callback)
        }
        Log.info(r.debugDescription)
    }

}
//MARK: 文件上传
extension ApiRequest{
    
    /// 上传图片 JSON
    public func uploadImage<T>(_ image : UIImage, params: Parameters?,_ callback: @escaping (_ response: ApiResponse<T>) -> Void){
        
        guard let url = URL(string: buidUrlString()) else {
            return
        }
        
        guard let data = image.data else { return }
        
        let re = self.codingURLRequest(url, method: HTTPMethod.post, params: params, timeout: 20.0)
        
        self.startLoading()
        self.request = NetworkManager.defaultManager.upload(data, with: re!)
        
        let dataType = self.options["dataType"] as! MIMEType
        switch dataType {
        case .json:
            request?.responseObject(queue: DispatchQueue.global(),  completionHandler: { (response:DataResponse<ApiResponse<T>>) in
                self.handleJSON(response, callback: callback)
            })
        default:
            self.stopLoading()
        }
        
        return
    }
    
    /// 上传文件 JSON
    
    public func uploadFile<T>(filePath file:String, params: Parameters?,_ callback: @escaping (_ response: ApiResponse<T>) -> Void){
        
        guard let url = URL(string: buidUrlString()) else {
            return
        }
        
        let fileUrl = URL(fileURLWithPath: file)
        
        let re = self.codingURLRequest(url, method: HTTPMethod.post, params: params, timeout: 20.0)
        
        self.startLoading()
        self.request = NetworkManager.defaultManager.upload(fileUrl, with: re!)
        
        let dataType = self.options["dataType"] as! MIMEType
        switch dataType {
        case .json:
            request?.responseObject(queue: DispatchQueue.global(),  completionHandler: { (response:DataResponse<ApiResponse<T>>) in
                self.handleJSON(response, callback: callback)
            })
        default:
            self.stopLoading()
        }
        
        return
    }
    
    //上传文件 Form表单
    public func uploadFile<T>(filePath file : String, fileName:String, params: Parameters?, _ callback: @escaping (_ response: ApiResponse<T>) -> Void){
        
        guard let url = URL(string: buidUrlString()) else {
            return
        }
        let fileUrl = URL(fileURLWithPath: file)
        
        let re = self.codingURLRequest(url, method: HTTPMethod.post, params: params, timeout: 20.0)
        
        self.startLoading()
        NetworkManager.defaultManager.upload(multipartFormData: { (multipartFormData:MultipartFormData) in
            multipartFormData.append(fileUrl, withName: fileName)
        }, with: re!) { (result:SessionManager.MultipartFormDataEncodingResult) in
            self.stopLoading()
            switch result {
            case .success(let upload, _, _):
                upload.responseObject(queue: DispatchQueue.global(), completionHandler: { (response:DataResponse<ApiResponse<T>>) in
                    self.handleJSON(response, callback: callback)
                })
            case .failure(_):
                let value = ApiResponse<T>()
                value.code = -1
                value.error = ApiError.dataError
                Queue.async {
                    callback(value)
                }
                break
            }
        }
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
