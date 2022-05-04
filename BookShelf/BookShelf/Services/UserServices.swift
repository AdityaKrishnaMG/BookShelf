//
//  UserServices.swift
//  BookShelf
//
//  Created by Aditya Krishna on 4/28/22.
//

import Foundation

protocol UserServices {
    func loginUser(with details: LoginDetails, success: ((UserDetails) -> Void)?, failure: ((String) -> Void)?)
    func registerUser(with details: LoginDetails, success: (() -> Void)?, failure: ((String) -> Void)?)
    func deleteUser(with id: String, success: (() -> Void)?, failure: ((String) -> Void)?)
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
    
    func registerUser(with details: LoginDetails, success: (() -> Void)?, failure: ((String) -> Void)?) {
        let params = details.asDictionary()
        serviceManager.post(url: Constants.URLs.Users.USERS_BASE_URL, parameters: params, headers: nil, success: { _ in
            success?()
        }, failure: { errorDescription in
            failure?(errorDescription)
        })
    }
    
    func deleteUser(with id: String, success: (() -> Void)?, failure: ((String) -> Void)?) {
        serviceManager.delete(url: Constants.URLs.Users.getUsersWithIdUrl(userId: id), parameters: nil, headers: nil, success: { _ in
            success?()
        }, failure: { errorDescription in
            failure?(errorDescription)
        })
    }
}
