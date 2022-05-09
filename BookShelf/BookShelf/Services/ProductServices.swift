//
//  ProductServices.swift
//  BookShelf
//
//  Created by Aditya Krishna on 5/3/22.
//

import Foundation

protocol ProductServices {
    func getAllProducts(success: (([ProductDetails]) -> Void)?, failure: ((String) -> Void)?)
    func getProductDetails(bookId: String, success: ((ProductDetails) -> Void)?, failure: ((String) -> Void)?)
    func addReview(with details: Review, bookId: String, success: (() -> Void)?, failure: ((String) -> Void)?)
}

class ProductServicesImp: ProductServices {
    var serviceManager: ServiceManager = ServiceManagerImp()
    
    func getAllProducts(success: (([ProductDetails]) -> Void)?, failure: ((String) -> Void)?) {
        serviceManager.get(url: Constants.URLs.Products.PRODUCTS_BASE_URL, parameters: nil, headers: nil, success: { response in
            let products = map(json: response[Strings.DATA]!, to: [ProductDetails].self)
            success?(products)
        }, failure: { errorDescription in
            failure?(errorDescription)
        })
    }
    
    func getProductDetails(bookId: String, success: ((ProductDetails) -> Void)?, failure: ((String) -> Void)?) {
        serviceManager.get(url: Constants.URLs.Products.getProductWithIdUrl(productId: bookId), parameters: nil, headers: nil, success: { details in
            let product = map(json: details, to: ProductDetails.self)
            success?(product)
        }, failure: { errorDescription in
            failure?(errorDescription)
        })
    }
    
    func addReview(with details: Review, bookId: String, success: (() -> Void)?, failure: ((String) -> Void)?) {
        let params = details.asDictionary()
        serviceManager.post(url: Constants.URLs.Products.getProductReviewUrl(productId: bookId), parameters: params, headers: nil, success: { _ in
            success?()
        }, failure: { errorDescription in
            failure?(errorDescription)
        })
    }
}
