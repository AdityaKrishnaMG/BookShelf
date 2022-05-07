//
//  PaymentViewModel.swift
//  BookShelf
//
//  Created by Aditya Krishna on 5/2/22.
//

import Foundation

protocol PaymentViewModel {
    var cartDetails: CartDetails { get set }
}

class PaymentViewModelImp: PaymentViewModel {
    var cartDetails: CartDetails
    
    init(cartDetails: CartDetails) {
        self.cartDetails = cartDetails
    }
}
