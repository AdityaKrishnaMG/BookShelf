//
//  BookDetailsModel.swift
//  BookShelf
//
//  Created by Aditya Krishna on 5/1/22.
//

import Foundation

struct ProductDetails: Codable {
    var id: String?
    var name: String?
    var image: String?
    var brand: String?
    var category: String?
    var description: String?
    var rating: Double?
    var numReviews: Int?
    var price: Double?
    var countInStock: Int?
    var user: String?
    var reviews: [Review]?
}

// MARK: - Review
struct Review: Codable {
    var name: String?
    var rating: Double?
    var comment: String?
    var id: String?
}
