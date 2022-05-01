//
//  Utils.swift
//  BookShelf
//
//  Created by Aditya Krishna on 4/27/22.
//

import Foundation

class Utils {
    let AUTHORIZATION = "AUTHORIZATION"
    
    func addAuthorizationTokenToHeaders(headers: [String: String]?) -> [String: String]? {
        var mutableHeaders = headers ?? [:]
        mutableHeaders[AUTHORIZATION] = Authorization.shared.userDetails.accessToken
        return mutableHeaders
    }
}

func map<T: Decodable>(json: Any, to type: T.Type) -> T {
    let parseData = try! JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
    let mappedObject = try! JSONDecoder().decode(T.self, from: parseData)
    return mappedObject
}
