//
//  PaymentModel.swift
//  BookShelf
//
//  Created by Aditya Krishna on 5/6/22.
//

import Foundation

enum PaymentType: String, Codable {
    case payPal = "PayPal"
    case creditCard = "Credit Card"
    case debitCard = "Debit Card"
}
