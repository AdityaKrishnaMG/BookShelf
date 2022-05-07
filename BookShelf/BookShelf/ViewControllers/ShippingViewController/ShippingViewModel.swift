//
//  ShippingViewModel.swift
//  BookShelf
//
//  Created by Aditya Krishna on 5/1/22.
//

import Foundation

protocol ShippingViewModel {
    var cartDetails: CartDetails { get set }
}

class ShippingViewModelImp: ShippingViewModel {
    var cartDetails: CartDetails
    
    init(cartDetails: CartDetails) {
        self.cartDetails = cartDetails
    }
}
