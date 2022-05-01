//
//  UIStoryboard.swift
//  BookShelf
//
//  Created by Aditya Krishna on 4/28/22.
//

import UIKit

extension UIStoryboard {
    static let LOGIN_VIEW_CONTROLLER = "LoginViewController"
    static let HOME_VIEW_CONTROLLER = "HomeViewController"
    static let PROFILE_VIEW_CONTROLLER = "ProfileViewController"
    
    static var loginViewController: UIStoryboard {
        UIStoryboard(name: LOGIN_VIEW_CONTROLLER, bundle: nil)
    }
    
    static var homeViewController: UIStoryboard {
        UIStoryboard(name: HOME_VIEW_CONTROLLER, bundle: nil)
    }
    
    static var profileViewController: UIStoryboard {
        UIStoryboard(name: PROFILE_VIEW_CONTROLLER, bundle: nil)
    }
}
