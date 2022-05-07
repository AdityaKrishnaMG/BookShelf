//
//  SummaryViewModel.swift
//  BookShelf
//
//  Created by Aditya Krishna on 5/6/22.
//

import Foundation

protocol SummaryViewModel {
    var cartDetails: CartDetails { get set }
    
    var didFetchData: (() -> Void)? { get set }
    var didFetchDataFailed: ((String) -> Void)? { get set }
    
    func confirmOrder()
}

class SummaryViewModelImp: SummaryViewModel {
    var cartDetails: CartDetails
    var services: OrderServices = OrderServicesImp()
    
    init(cartDetails: CartDetails) {
        self.cartDetails = cartDetails
    }
    
    var didFetchData: (() -> Void)?
    var didFetchDataFailed: ((String) -> Void)?
    
    func confirmOrder() {
        services.createOrder(with: cartDetails, success: { [weak self ] in
            self?.didFetchData?()
        }, failure: { [weak self ] errorDescription in
            self?.didFetchDataFailed?(errorDescription)
        })
    }
}
