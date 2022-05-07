//
//  BookDetailsViewModel.swift
//  BookShelf
//
//  Created by Aditya Krishna on 5/1/22.
//

import Foundation

protocol BookDetailsViewModel {
    var productDetails: ProductDetails? { get set }
    
    var didFetchData: (() -> Void)?  { get set }
    var didFetchDataFailed: ((String) -> Void)? { get set }
    
    func getData()
}

class BookDetailsViewModelImp: BookDetailsViewModel {
    var bookId: String
    var services: ProductServices = ProductServicesImp()
    
    init(bookId: String) {
        self.bookId = bookId
    }
    
    var productDetails: ProductDetails?
    
    var didFetchData: (() -> Void)?
    var didFetchDataFailed: ((String) -> Void)?
    
    func getData() {
        services.getProductDetails(bookId: bookId, success: { [weak self] details in
            self?.productDetails = details
            self?.didFetchData?()
        }, failure: { [weak self] errorDescription in
            self?.didFetchDataFailed?(errorDescription)
        })
    }
}
