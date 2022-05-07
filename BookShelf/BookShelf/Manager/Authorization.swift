//
//  Authorization.swift
//  BookShelf
//
//  Created by Aditya Krishna on 4/27/22.
//

import UIKit

class Authorization {
    static let shared = Authorization()
    
    var userDetails: UserDetails!
    
    func logout() {
        UIApplication.shared.windows.first?.rootViewController = UIViewController.loginViewController()
        UIApplication.shared.windows.first?.makeKeyAndVisible()
    }
}
