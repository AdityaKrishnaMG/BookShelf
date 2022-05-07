//
//  ProfileViewModel.swift
//  BookShelf
//
//  Created by Aditya Krishna on 4/28/22.
//

import Foundation

protocol ProfileViewModel {
    var orders: [Order] { get set }
    
    var didUpdateDetails: (() -> Void)? { get set }
    var didUpdateDetailsFailed: ((String) -> Void)? { get set }
    var didFetchDetails: (() -> Void)? { get set }
    var didFetchDetailsFailed: ((String) -> Void)? { get set }
    
    func getOrders()
    func updateUser()
}

class ProfileViewModelImp: ProfileViewModel {
    var orders: [Order] = []
    var userDetails: LoginDetails = LoginDetails()
    
    var orderServices: OrderServices = OrderServicesImp()
    var userServices: UserServices = UserServicesImp()
    
    var didUpdateDetails: (() -> Void)?
    var didUpdateDetailsFailed: ((String) -> Void)?
    
    var didFetchDetails: (() -> Void)?
    var didFetchDetailsFailed: ((String) -> Void)?
    
    func getOrders() {
        orderServices.getMyOrders(success: { [weak self ] orders in
            self?.orders = orders
            self?.didFetchDetails?()
        }, failure: { [weak self ] errorDescription in
            self?.didFetchDetailsFailed?(errorDescription)
        })
    }
    
    func updateUser() {
        userServices.updateUser(with: userDetails, success: { [ weak self ] userData in
            if let refreshToken = userData.refreshToken, !refreshToken.isEmpty {
                Authorization.shared.userDetails.accessToken = refreshToken
            }
            
            self?.didUpdateDetails?()
        }, failure: { [ weak self ] error in
            self?.didUpdateDetailsFailed?(error)
        })
    }
}
