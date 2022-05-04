//
//  BookListViewModel.swift
//  BookShelf
//
//  Created by Aditya Krishna on 5/1/22.
//

import Foundation

protocol BookListViewModel {
    var products: [ProductDetails] { get set }
    
    var didFetchData: (() -> Void)? { get set }
    var didFetchDataFailed: ((String) -> Void)? { get set }
    
    func getData()
}

class BookListViewModelImp: BookListViewModel {
    let services: ProductServices = ProductServicesImp()
    
    var products: [ProductDetails] = []
    
    var didFetchData: (() -> Void)?
    var didFetchDataFailed: ((String) -> Void)?
    
    func getData() {
        services.getAllProducts(success: { [weak self] products in
            self?.products = products
            self?.didFetchData?()
        }, failure: { [weak self] errorDescription in
            self?.didFetchDataFailed?(errorDescription)
        })
    }
}
