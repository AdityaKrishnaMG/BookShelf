//
//  UIViewController.swift
//  BookShelf
//
//  Created by Aditya Krishna on 4/28/22.
//

import UIKit

extension UIViewController {
    static func loginViewController() -> LoginViewController {
        let storyboard = UIStoryboard.loginViewController
        guard let viewController = storyboard.instantiateInitialViewController() as? LoginViewController else {
            fatalError("Could not instantiate view controller")
        }
        
        return viewController
    }
    
    static func homeViewController() -> HomeViewController {
        let storyboard = UIStoryboard.homeViewController
        guard let viewController = storyboard.instantiateInitialViewController() as? HomeViewController else {
            fatalError("Could not instantiate view controller")
        }
        
        return viewController
    }
    
    static func profileViewController() -> ProfileViewController {
        let storyboard = UIStoryboard.profileViewController
        guard let viewController = storyboard.instantiateInitialViewController() as? ProfileViewController else {
            fatalError("Could not instantiate view controller")
        }
        
        return viewController
    }
}
