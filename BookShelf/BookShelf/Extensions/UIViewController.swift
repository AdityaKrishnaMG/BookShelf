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
    
    static func bookListViewController() -> BookListViewController {
        let storyboard = UIStoryboard.bookListViewController
        guard let viewController = storyboard.instantiateInitialViewController() as? BookListViewController else {
            fatalError("Could not instantiate view controller")
        }
        
        return viewController
    }
    
    static func bookDetailsViewController(bookId: String) -> BookDetailsViewController {
        let storyboard = UIStoryboard.bookDetailsViewController
        guard let viewController = storyboard.instantiateInitialViewController() as? BookDetailsViewController else {
            fatalError("Could not instantiate view controller")
        }
        
        viewController.viewModel = BookDetailsViewModelImp(bookId: bookId)
        
        return viewController
    }
    
    static func cartViewController() -> CartViewController {
        let storyboard = UIStoryboard.cartViewController
        guard let viewController = storyboard.instantiateInitialViewController() as? CartViewController else {
            fatalError("Could not instantiate view controller")
        }
        
        return viewController
    }
    
    static func shippingViewController(cartDetails: CartDetails) -> ShippingViewController {
        let storyboard = UIStoryboard.shippingViewController
        guard let viewController = storyboard.instantiateInitialViewController() as? ShippingViewController else {
            fatalError("Could not instantiate view controller")
        }
        
        viewController.viewModel = ShippingViewModelImp(cartDetails: cartDetails)
        
        return viewController
    }
    
    static func paymentViewController(cartDetails: CartDetails) -> PaymentViewController {
        let storyboard = UIStoryboard.paymentViewController
        guard let viewController = storyboard.instantiateInitialViewController() as? PaymentViewController else {
            fatalError("Could not instantiate view controller")
        }
        
        viewController.viewModel = PaymentViewModelImp(cartDetails: cartDetails)
        
        return viewController
    }
    
    static func summaryViewController(cartDetails: CartDetails) -> SummaryViewController {
        let storyboard = UIStoryboard.summaryViewController
        guard let viewController = storyboard.instantiateInitialViewController() as? SummaryViewController else {
            fatalError("Could not instantiate view controller")
        }
        
        viewController.viewModel = SummaryViewModelImp(cartDetails: cartDetails)
        
        return viewController
    }
}

extension UIViewController {
    func showAlert(with error: String) {
        let alertController = UIAlertController(title: Strings.ERROR, message: error, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: Strings.OK, style: .cancel)
        alertController.addAction(alertAction)
        present(alertController, animated: true)
    }
    
    func showMessageAlert(with message: String) {
        let alertController = UIAlertController(title: Strings.ALERT, message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: Strings.OK, style: .cancel)
        alertController.addAction(alertAction)
        present(alertController, animated: true)
    }
    
    func addStatusBarBackground(with color: UIColor) {
        let view = UIView(frame: UIApplication.shared.statusBarFrame)
        view.backgroundColor = color
        view.autoresizingMask = [.flexibleWidth]
        self.view.addSubview(view)
        self.view.bringSubviewToFront(view)
    }
}
