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
    static let BOOK_LIST_VIEW_CONTROLLER = "BookListViewController"
    static let BOOK_DETAILS_VIEW_CONTROLLER = "BookDetailsViewController"
    static let CART_VIEW_CONTROLLER = "CartViewController"
    static let SHIPPING_VEIW_CONTROLLER = "ShippingViewController"
    static let PAYMENT_VIEW_CONTROLLER = "PaymentViewController"
    static let SUMMARY_VIEW_CONTROLLER = "SummaryViewController"
    
    static var loginViewController: UIStoryboard {
        UIStoryboard(name: LOGIN_VIEW_CONTROLLER, bundle: nil)
    }
    
    static var homeViewController: UIStoryboard {
        UIStoryboard(name: HOME_VIEW_CONTROLLER, bundle: nil)
    }
    
    static var profileViewController: UIStoryboard {
        UIStoryboard(name: PROFILE_VIEW_CONTROLLER, bundle: nil)
    }
    
    static var bookListViewController: UIStoryboard {
        UIStoryboard(name: BOOK_LIST_VIEW_CONTROLLER, bundle: nil)
    }
    
    static var bookDetailsViewController: UIStoryboard {
        UIStoryboard(name: BOOK_DETAILS_VIEW_CONTROLLER, bundle: nil)
    }
    
    static var cartViewController: UIStoryboard {
        UIStoryboard(name: CART_VIEW_CONTROLLER, bundle: nil)
    }
    
    static var paymentViewController: UIStoryboard {
        UIStoryboard(name: PAYMENT_VIEW_CONTROLLER, bundle: nil)
    }
    
    static var summaryViewController: UIStoryboard {
        UIStoryboard(name: SUMMARY_VIEW_CONTROLLER, bundle: nil)
    }
    
    static var shippingViewController: UIStoryboard {
        UIStoryboard(name: SHIPPING_VEIW_CONTROLLER, bundle: nil)
    }
}
