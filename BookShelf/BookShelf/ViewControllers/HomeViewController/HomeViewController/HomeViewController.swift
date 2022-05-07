//
//  HomeViewController.swift
//  BookShelf
//
//  Created by Aditya Krishna on 4/28/22.
//

import UIKit

class HomeViewController: UITabBarController {
    var profileViewController: ProfileViewController!
    var bookListViewController: BookListViewController!
    var cartViewController: CartViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setupViewControllers()
    }
    
    private func setupViewControllers() {
        setupProfileViewController()
        
        setupHomeRootViewController()
        setupCartRootViewController()
        
        viewControllers = [bookListViewController, cartViewController, profileViewController]
    }
    
    private func setupProfileViewController() {
        profileViewController = UIViewController.profileViewController()
        profileViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .contacts, tag: 2)
    }
    
    func setupHomeRootViewController() {
        bookListViewController = UIViewController.bookListViewController()
        bookListViewController.delegate = self
        bookListViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .featured, tag: 0)
    }
    
    func setupCartRootViewController() {
        cartViewController = UIViewController.cartViewController()
        cartViewController.delegate = self
        cartViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .bookmarks, tag: 1)
    }
}

extension HomeViewController: BookListViewControllerDelegate {
    func bookListViewController(_ bookListViewController: BookListViewController, didAddBook book: ProductDetails) {
        cartViewController.viewModel.products.append(book)
    }
}

extension HomeViewController: CartViewControllerDelegate {
    func cartViewControllerDidConformOrder(_ cartViewController: CartViewController) {
        navigationController?.popToRootViewController(animated: true)
        selectedIndex = 0
        setupCartRootViewController()
        viewControllers = [bookListViewController, self.cartViewController, profileViewController]
    }
}
