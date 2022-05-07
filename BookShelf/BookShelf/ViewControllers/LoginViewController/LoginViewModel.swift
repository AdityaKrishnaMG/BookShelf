//
//  LoginViewModel.swift
//  BookShelf
//
//  Created by Aditya Krishna on 4/28/22.
//

import Foundation

protocol LoginViewModel {
    var details: LoginDetails { get set }
    
    var didFetchDetails: (() -> Void)? { get set }
    var didFetchDetailsFailed: ((String) -> Void)? { get set }
    
    func login()
}

class LoginViewModelImp: LoginViewModel {
    var details: LoginDetails = LoginDetails(email: "admin@example.com", password: "123456")
    
    var services: UserServices = UserServicesImp()
    
    var didFetchDetails: (() -> Void)?
    var didFetchDetailsFailed: ((String) -> Void)?
    
    func login() {
        services.loginUser(with: details, success: { [weak self] userDetails in
            Authorization.shared.userDetails = userDetails
            self?.didFetchDetails?()
        }, failure: { [weak self] errorDescription in
            self?.didFetchDetailsFailed?(errorDescription)
        })
    }
}
