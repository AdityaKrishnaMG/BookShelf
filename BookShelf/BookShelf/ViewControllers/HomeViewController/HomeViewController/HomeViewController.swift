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
        
        self.tabBar.backgroundColor = UIColor(red: 1/255, green: 25/255, blue: 54/255, alpha: 1)
        self.tabBar.unselectedItemTintColor = .lightGray
        self.tabBar.tintColor = UIColor(red: 255/255, green: 107/255, blue: 107/255, alpha: 1)
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
        profileViewController.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person.crop.circle.fill"), tag: 2)
    }
    
    func setupHomeRootViewController() {
        bookListViewController = UIViewController.bookListViewController()
        bookListViewController.delegate = self
        bookListViewController.tabBarItem = UITabBarItem(title: "Books", image: UIImage(systemName: "book.fill"), tag: 0)
    }
    
    func setupCartRootViewController() {
        cartViewController = UIViewController.cartViewController()
        cartViewController.delegate = self
        cartViewController.tabBarItem = UITabBarItem(title: "Cart", image: UIImage(systemName: "cart.fill"), tag: 1)
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
