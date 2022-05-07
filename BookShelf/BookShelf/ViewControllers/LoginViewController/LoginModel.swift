//
//  LoginModel.swift
//  BookShelf
//
//  Created by Aditya Krishna on 4/28/22.
//

import Foundation

struct LoginDetails: Codable {
    var name: String?
    var email: String?
    var password: String?
}

struct UserDetails: Codable {
    var id: String
    var name: String
    var email: String
    var roles: [String]
    var accessToken: String
    var tokenType: String
    var refreshToken: String?
}
