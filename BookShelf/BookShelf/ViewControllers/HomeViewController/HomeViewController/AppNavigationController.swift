//
//  AppNavigationController.swift
//  BookShelf
//
//  Created by Aditya Krishna on 4/28/22.
//

import UIKit

class AppNavigationController: UINavigationController {
    var bookListViewController: BookListViewController!
    var cartViewController: CartViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func setupHomeRootViewController() {
        bookListViewController = UIViewController.bookListViewController()
        viewControllers = [bookListViewController]
    }
    
    func setupCartRootViewController() {
        cartViewController = UIViewController.cartViewController()
        viewControllers = [cartViewController]
    }
}
