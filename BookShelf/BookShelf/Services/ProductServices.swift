//
//  ProductServices.swift
//  BookShelf
//
//  Created by Aditya Krishna on 5/3/22.
//

import Foundation

protocol ProductServices {
    func getAllProducts(success: (([ProductDetails]) -> Void)?, failure: ((String) -> Void)?)
}

class ProductServicesImp: ProductServices {
    private let serviceManager: ServiceManager = ServiceManager()
    
    func getAllProducts(success: (([ProductDetails]) -> Void)?, failure: ((String) -> Void)?) {
        serviceManager.get(url: Constants.URLs.Products.PRODUCTS_BASE_URL, parameters: nil, headers: nil, success: { response in
            let products = map(json: response, to: [ProductDetails].self)
            success?(products)
        }, failure: { errorDescription in
            failure?(errorDescription)
        })
    }
}
