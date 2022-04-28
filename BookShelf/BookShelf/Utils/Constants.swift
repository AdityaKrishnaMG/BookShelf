//
//  Constants.swift
//  BookShelf
//
//  Created by Aditya Krishna on 4/27/22.
//

import Foundation

struct Constants {
    struct URLs {
        static let BASE_URL = "http://localhost:8080/api/"
        
        struct Users {
            static let USERS_BASE_URL = BASE_URL + "users/"
            static let login = USERS_BASE_URL + "login"
            static let profile = USERS_BASE_URL + "profile"
            
            static func getUsersWithIdUrl(userId: String) -> String {
                USERS_BASE_URL + userId
            }
        }
        
        struct Products {
            static let PRODUCTS_BASE_URL = BASE_URL + "products/"
            
            static func getProductWithIdUrl(productId: String) -> String {
                PRODUCTS_BASE_URL + productId
            }
            
            static func getProductReviewUrl(productId: String) -> String {
                getProductWithIdUrl(productId: productId) + "/review"
            }
        }
        
        
        struct Orders {
            static let ORDERS_BASE_URL = BASE_URL + "orders/"
            static let myOrders = ORDERS_BASE_URL + "myorders"
            
            static func getOrderWithIdUrl(orderId: String) -> String {
                ORDERS_BASE_URL + orderId
            }
            
            static func updateToDelivered(orderId: String) -> String {
                getOrderWithIdUrl(orderId: orderId) + "/deliver"
            }
            
            static func updateToPaid(orderId: String) -> String {
                getOrderWithIdUrl(orderId: orderId) + "/pay"
            }
        }
    }
}
