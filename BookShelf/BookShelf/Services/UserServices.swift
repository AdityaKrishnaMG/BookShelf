//
//  UserServices.swift
//  BookShelf
//
//  Created by Aditya Krishna on 4/28/22.
//

import Foundation

protocol UserServices {
    func loginUser(with details: LoginDetails, success: ((UserDetails) -> Void)?, failure: ((String) -> Void)?)
}

class UserServicesImp: UserServices {
    private let serviceManager: ServiceManager = ServiceManager()
    
    func loginUser(with details: LoginDetails, success: ((UserDetails) -> Void)?, failure: ((String) -> Void)?) {
        let params = details.asDictionary()
        serviceManager.post(url: Constants.URLs.Users.login, parameters: params, headers: nil, success: { response in
            let userDetails = map(json: response, to: UserDetails.self)
            success?(userDetails)
        }, failure: { errorDescription in
            failure?(errorDescription)
        })
    }
}
