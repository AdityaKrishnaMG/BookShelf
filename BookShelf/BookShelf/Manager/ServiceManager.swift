//
//  ServiceManager.swift
//  BookShelf
//
//  Created by Aditya Krishna on 4/27/22.
//

import Foundation
import Alamofire

class ServiceManager {
    func get(url: String, parameters: [String: Any]?, headers: [String: String]?, success: (([String: Any]) -> Void)?, failure: ((String) -> Void)?) {
        guard let url = URL(string: url) else {
            return
        }
        
        let mutableHeaders = addAuthorizationTokenToHeaders(headers: headers)
        let headers = getHTTPHeadersFrom(dictionary: mutableHeaders) ?? HTTPHeaders()
        
        AF.request(url, method: .get, parameters: parameters, encoding: JSONEncoding.default, headers: headers).validate().response { [weak self] response in
            self?.processResponse(response: response, success: success, failure: failure)
        }
    }
    
    func post(url: String, parameters: [String: Any]?, headers: [String: String]?, success: (([String: Any]) -> Void)?, failure: ((String) -> Void)?) {
        guard let url = URL(string: url) else {
            return
        }
        
        let mutableHeaders = addAuthorizationTokenToHeaders(headers: headers)
        var headers = getHTTPHeadersFrom(dictionary: mutableHeaders) ?? HTTPHeaders()
        headers.add(HTTPHeader.contentType("application/json"))
        
        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).validate().response { [weak self] response in
            self?.processResponse(response: response, success: success, failure: failure)
        }
    }
    
    func put(url: String, parameters: [String: Any]?, headers: [String: String]?, success: (([String: Any]) -> Void)?, failure: ((String) -> Void)?) {
        guard let url = URL(string: url) else {
            return
        }
        
        let mutableHeaders = addAuthorizationTokenToHeaders(headers: headers)
        var headers = getHTTPHeadersFrom(dictionary: mutableHeaders) ?? HTTPHeaders()
        headers.add(HTTPHeader.contentType("application/json"))
        
        AF.request(url, method: .put, parameters: parameters, encoding: JSONEncoding.default, headers: headers).validate().response { [weak self] response in
            self?.processResponse(response: response, success: success, failure: failure)
        }
    }
    
    func delete(url: String, parameters: [String: Any]?, headers: [String: String]?, success: (([String: Any]) -> Void)?, failure: ((String) -> Void)?) {
        guard let url = URL(string: url) else {
            return
        }
        
        let mutableHeaders = addAuthorizationTokenToHeaders(headers: headers)
        var headers = getHTTPHeadersFrom(dictionary: mutableHeaders) ?? HTTPHeaders()
        headers.add(HTTPHeader.contentType("application/json"))
        
        AF.request(url, method: .delete, parameters: parameters, encoding: JSONEncoding.default, headers: headers).validate().response { [weak self] response in
            self?.processResponse(response: response, success: success, failure: failure)
        }
    }
}

// MARK: - Methods to handle response
extension ServiceManager {
    private func processResponse(response: AFDataResponse<Data?>, success: (([String: Any]) -> Void)?, failure: ((String) -> Void)?) {
        switch response.result {
        case .success:
            let responseMap = (try! JSONSerialization.jsonObject(with: response.value!!, options: []) as? [String: Any]) ?? [String: Any]()
            print("ResponseMap: \(responseMap)")
            success?(responseMap)
            
        case let .failure(error):
            print("Error: \(error.localizedDescription)")
            failure?(error.localizedDescription)
        }
    }
}

// MARK: - Helper methods
extension ServiceManager {
    private func getHTTPHeadersFrom(dictionary: [String: String]?) -> HTTPHeaders? {
        guard let dictionary = dictionary else {
            return nil
        }
        
        return HTTPHeaders(dictionary)
    }
    
    private func addAuthorizationTokenToHeaders(headers: [String: String]?) -> [String: String]? {
        guard let authToken = Authorization.shared.userDetails?.accessToken else {
            return headers
        }
        
        var mutableHeaders = headers ?? [:]
        mutableHeaders[Strings.AUTHORIZATION] = "Bearer " + authToken
        return mutableHeaders
    }
}
