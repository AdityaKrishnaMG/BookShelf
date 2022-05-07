//
//  CartViewModel.swift
//  BookShelf
//
//  Created by Aditya Krishna on 5/1/22.
//

import Foundation

protocol CartViewModel {
    var products: [ProductDetails] { get set }
    var cartDetails: CartDetails { get set }
}

class CartViewModelImp: CartViewModel {
    var products: [ProductDetails] = [] {
        didSet {
            cartDetails.assignToOrderItems(products: products)
        }
    }
    
    var cartDetails: CartDetails = CartDetails()
}
