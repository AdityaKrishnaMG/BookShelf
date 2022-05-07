//
//  ProfileModel.swift
//  BookShelf
//
//  Created by Aditya Krishna on 4/28/22.
//

import Foundation

struct Order: Codable {
    var id, userId: String?
    var orderItems: [OrderItem]?
    var shippingAddress: ShippingAddress?
    var paymentMethod: String?
    var taxPrice, shippingPrice: Int?
    var totalPrice: Double?
    var paidAt, deliveredAt, paymentResult: String?
    var delivered, paid: Bool?
}

struct ShippingAddress: Codable {
    var address, city, postalCode, country: String?
}
