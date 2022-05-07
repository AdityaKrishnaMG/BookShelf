//
//  BookDetailsViewModel.swift
//  BookShelf
//
//  Created by Aditya Krishna on 5/1/22.
//

import Foundation

protocol BookDetailsViewModel {
    var productDetails: ProductDetails? { get set }
    var review: Review { get set }
    
    var didAddReview: (() -> Void)? { get set }
    var didAddReviewFail: ((String) -> Void)? { get set }
    var didFetchData: (() -> Void)?  { get set }
    var didFetchDataFailed: ((String) -> Void)? { get set }
    
    func getData()
    func addReview()
}

class BookDetailsViewModelImp: BookDetailsViewModel {
    var bookId: String
    var services: ProductServices = ProductServicesImp()
    
    init(bookId: String) {
        self.bookId = bookId
    }
    
    var productDetails: ProductDetails?
    var review: Review = Review()
    
    var didAddReview: (() -> Void)?
    var didAddReviewFail: ((String) -> Void)?
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
    
    func addReview() {
        services.addReview(with: review, bookId: bookId, success: { [ weak self ] in
            self?.didAddReview?()
        }, failure: { [ weak self ] error in
            self?.didAddReviewFail?(error)
        })
    }
}
