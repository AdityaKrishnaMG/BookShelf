//
//  HomeViewController.swift
//  BookShelf
//
//  Created by Aditya Krishna on 4/28/22.
//

import UIKit

class HomeViewController: UITabBarController {
    var homeAppNavigation: AppNavigationController!
    var cartAppNavigation: AppNavigationController!
    var profileViewController: ProfileViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setupViewControllers()
    }
    
    private func setupViewControllers() {
        setupHomeNavigationController()
        setupCartNavigationController()
        setupProfileViewController()
        
        viewControllers = [homeAppNavigation, cartAppNavigation, profileViewController]
    }
    
    private func setupHomeNavigationController() {
        homeAppNavigation = AppNavigationController()
        homeAppNavigation.tabBarItem = UITabBarItem(tabBarSystemItem: .featured, tag: 0)
        homeAppNavigation.setupHomeRootViewController()
    }
    
    private func setupCartNavigationController() {
        cartAppNavigation = AppNavigationController()
        cartAppNavigation.tabBarItem = UITabBarItem(tabBarSystemItem: .bookmarks, tag: 0)
        cartAppNavigation.setupCartRootViewController()
    }
    
    private func setupProfileViewController() {
        profileViewController = UIViewController.profileViewController()
        profileViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .contacts, tag: 1)
    }
}
