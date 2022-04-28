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
        mutableHeaders[AUTHORIZATION] = Authorization.shared.authToken
        return mutableHeaders
    }
}
