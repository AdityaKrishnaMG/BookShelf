//
//  OrderServices.swift
//  BookShelf
//
//  Created by Aditya Krishna on 5/6/22.
//

import Foundation

protocol OrderServices {
    func createOrder(with details: CartDetails, success: (() -> Void)?, failure: ((String) -> Void)?)
    func getMyOrders(success: (([Order]) -> Void)?, failure: ((String) -> Void)?)
}

class OrderServicesImp: OrderServices {
    var serviceManager: ServiceManager = ServiceManager()
    
    func createOrder(with details: CartDetails, success: (() -> Void)?, failure: ((String) -> Void)?) {
        let params = details.asDictionary()
        serviceManager.post(url: Constants.URLs.Orders.ORDERS_BASE_URL, parameters: params, headers: nil, success: { response in
            success?()
        }, failure: { errorDescription in
            failure?(errorDescription)
        })
    }
    
    func getMyOrders(success: (([Order]) -> Void)?, failure: ((String) -> Void)?) {
        serviceManager.get(url: Constants.URLs.Orders.myOrders, parameters: nil, headers: nil, success: { response in
            let orders = map(json: response[Strings.DATA]!, to: [Order].self)
            success?(orders)
        }, failure: { errorDescription in
            failure?(errorDescription)
        })
    }
}
