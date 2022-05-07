//
//  CartModel.swift
//  BookShelf
//
//  Created by Aditya Krishna on 5/1/22.
//

import Foundation

struct CartDetails: Codable {
    var orderItems: [OrderItem]?
    var address, city, postalCode, country: String?
    var paymentMethod: String?
    var itemsPrice: Double?
    var taxPrice, shippingPrice: Double?
    var totalPrice: Double?
    
    mutating func assignToOrderItems(products: [ProductDetails]) {
        orderItems = products.map({ OrderItem(product: $0) })
        itemsPrice = products.reduce(into: 0, { partialResult, product in
            partialResult += Double(product.qty ?? 0) * (product.price ?? 4)
        })
        shippingPrice = 9
        totalPrice = (itemsPrice ?? 0) + Double(shippingPrice ?? 0)
    }
}

struct OrderItem: Codable {
    var name: String?
    var qty: Int?
    var image: String?
    var productId: String?
    
    init(product: ProductDetails) {
        self.name = product.name
        self.qty = product.qty
        self.image = product.image
        self.productId = product.id
    }
}
