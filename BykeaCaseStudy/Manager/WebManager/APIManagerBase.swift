//
//    APIManagerBase.swift
//  BykeaCaseStudy
//
//  Created by Hafiz Saad on 24/06/2021.
//

import UIKit
import Alamofire

typealias DefaultAPIFailureClosure = (NSError) -> Void
typealias QTDefaultAPISuccessClosure = (Dictionary<String,AnyObject>, Any?) -> Void

class APIManagerBase: NSObject
{
    var alamoFireManager : SessionManager!
    let defaultRequestHeader = ["Content-Type" : "application/x-www-form-urlencoded"]
    let otherRequestHeader = ["Authorization": "bearer"]
    
    override init()
    {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = TimeInterval(Constants.apiRequestTimeoutInterval)
        configuration.timeoutIntervalForResource = TimeInterval(Constants.apiRequestTimeoutInterval)
        alamoFireManager = Alamofire.SessionManager(configuration: configuration)
    }
}

extension APIManagerBase
{
    
    func getHeaders () -> Dictionary<String,String>
    {
        return ["Content-Type" : "application/json"]
    }
    
    func getAuthorizationHeader () -> HTTPHeaders
    {
        return [ "Content-Type" : "application/json", "Authorization" : "Basic cXVpY2t0YXhpLWFwcGxpY2F0aW9uOnVzZXI=", "PushToken" : ""]
    }
    
    func getAuthorizationHeaderForPostRequest (isMultiPart : Bool? = false) -> HTTPHeaders
    {
        let token = "User Token"
        if token != ""
        {
            if isMultiPart!
            {
                return ["content-type": "multipart/form-data; boundary=----WebKitFormBoundary7MA4YWxkTrZu0gW", "Authorization": "Bearer \(token)", "PushToken" : ""]
                
            }
            return ["Content-Type" : "application/x-www-form-urlencoded", "Authorization": "Basic \(token)", "PushToken" : ""]
        }
        else
        {
            return ["Content-Type" : "application/x-www-form-urlencoded", "PushToken" : ""]
        }
    }
    
    func getUrl(forRoute route: String, params:Parameters? = nil) -> URL?
    {
        if let components: NSURLComponents  = NSURLComponents(string: (Constants.BaseURL+route))
        {
            if let params = params
            {
                var queryItems = [URLQueryItem]()
                for (key,value) in params
                {
                    queryItems.append(URLQueryItem(name:key,value: value as? String))
                }
                components.queryItems = queryItems
            }
            
            return components.url
        }
        return nil
    }
}

extension APIManagerBase
{
    func stopAllrequests()
    {
        self.alamoFireManager.session.getAllTasks
        { (tasks) in
            tasks.forEach { $0.cancel() }
        }
    }
}

extension APIManagerBase
{
    
    func getRequestWith(route: String, parameters: Parameters,
                        success:@escaping QTDefaultAPISuccessClosure,
                        failure:@escaping DefaultAPIFailureClosure,
                        errorPopup: Bool)
    {
        
        if !(NetworkReachabilityManager.init(host: "www.apple.com")?.isReachable)!
        {
            
            print("internet not reachable")
            let error = NSError(domain: "no internet connection", code: 500, userInfo: nil)
            
            failure(error)
            return
        }
        
        Alamofire.request(route, method: .get, encoding: JSONEncoding.default, headers: getAuthorizationHeader()).responseJSON
        { response in
            
            print(response)
            switch response.result
            {
            case .success:
                print(response.value as? Dictionary<String, AnyObject>)
                //Success
                
                if response.value is [[String:Any]]
                {
                    var dict = Dictionary<String, AnyObject>()
                    dict["data"] = response.value as AnyObject
                    success(dict, response.data)
                }
                else
                {
                    success(response.value as! Dictionary<String, AnyObject>, response.data)
                }
                
                break
                
            case .failure(_):
                if response.response?.statusCode == 200
                {
                    var dict = Dictionary<String, AnyObject>()
                    dict["statusCode"] = "200" as AnyObject
                    success(dict, nil)
                }
                else
                {
                    failure(response.error! as NSError)
                }
                break
            }
        }
    }
    
    
    func postRequestWith(route: URL, params:Parameters,
                         success:@escaping QTDefaultAPISuccessClosure,
                         failure:@escaping DefaultAPIFailureClosure,
                         errorPopup: Bool)
    {
        if !(NetworkReachabilityManager.init(host: "www.apple.com")?.isReachable)!
        {
            print("internet not reachable")
            let error = NSError(domain: "no internet connection", code: 500, userInfo: nil)
            failure(error)
            return
        }
        
        Alamofire.request(route, method: .post, parameters: params, headers: getAuthorizationHeaderForPostRequest()).responseJSON
        { response in
            
            switch response.result
            {
            case .success:
                
                if let responseData = response.value as? Dictionary<String, AnyObject>
                {
                    success(responseData, response.data)
                }
                
                if let rData = response.value as? NSString
                {
                    let data:Dictionary<String, AnyObject> = ["message":rData]
                    success(data, response.data)
                }
                
                break
                
            case .failure(_):
                
                failure(response.error! as NSError)
                
                break
            }
        }
    }
    
    func deleteRequestWith(route: URL, params:Parameters, success:@escaping QTDefaultAPISuccessClosure, failure:@escaping DefaultAPIFailureClosure, errorPopup: Bool)
    {
        
        if !(NetworkReachabilityManager.init(host: "www.apple.com")?.isReachable)!
        {
            
            print("internet not reachable")
            let error = NSError(domain: "no internet connection", code: 500, userInfo: nil)
            
            failure(error)
            return
        }
        print(getAuthorizationHeader())
        Alamofire.request(route, method: .delete, parameters: params,encoding: JSONEncoding.default, headers: getAuthorizationHeader()).responseJSON
        { response in
            
            switch response.result
            {
            case .success:
                
                //Success
                success(response.value as! Dictionary<String, AnyObject>, response.data)
                break
                
            case .failure(_):
                failure(response.error! as NSError)
                break
            }
        }
    }
    
    func putRequestWith(route: URL,params: Parameters,
                        success:@escaping QTDefaultAPISuccessClosure,
                        failure:@escaping DefaultAPIFailureClosure,
                        errorPopup: Bool)
    {
        if !(NetworkReachabilityManager.init(host: "www.apple.com")?.isReachable)!
        {
            print("internet not reachable")
            let error = NSError(domain: "no internet connection", code: 500, userInfo: nil)
            failure(error)
            return
        }
        
        Alamofire.request(route, method: .put, parameters: params, encoding: JSONEncoding.default, headers: getAuthorizationHeader()).responseJSON
        { response in
            
            switch response.result
            {
            case .success:
                success(response.value as! Dictionary<String, AnyObject>, response.data)
                break
                
            case .failure(_):
                failure(response.error! as NSError)
                break
            }
        }
    }
    
    
    func postRequestWithMultipart(route: URL,params: Parameters,
                                  success:@escaping QTDefaultAPISuccessClosure,
                                  failure:@escaping DefaultAPIFailureClosure,
                                  errorPopup: Bool)
    {
        
        if !(NetworkReachabilityManager.init(host: "www.apple.com")?.isReachable)!
        {
            
            print("internet not reachable")
            let error = NSError(domain: "no internet connection", code: 500, userInfo: nil)
            
            failure(error)
            return
        }
        
        let URLSTR = try! URLRequest(url: route.absoluteString, method: .post, headers: getAuthorizationHeaderForPostRequest())
        
        Alamofire.upload(multipartFormData:
        { multipart in
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'_'HH-mm-ss"
            
            for (key , value) in params
            {
                
                if let data:Data = value as? Data
                {
                    let dateString = dateFormatter.string(from: Date())
                    let imageName = "\(key)_\(dateString).png"
                    multipart.append(data, withName: key, fileName: imageName, mimeType: "image/jpeg")
                }
                else
                {
                    multipart.append("\(value)".data(using: String.Encoding.utf8)!, withName: key)
                }
            }
            
        },
        to:route.absoluteString,headers:getAuthorizationHeaderForPostRequest(isMultiPart: true))
        { (result) in
            switch result
            {
            case .success(let upload, _, _):
                
                upload.uploadProgress(closure:
                { (progress) in
                    print("Upload Progress: \(progress.fractionCompleted)")
                })
                
                upload.responseJSON
                { response in
                    print(response.result.value)
                    
                    success(response.result.value as! Dictionary<String, AnyObject>, response.data)
                    
                }
                break
                
            case .failure(let encodingError):
                print(encodingError)
                failure(encodingError as NSError)
            }
        }
    }
}
