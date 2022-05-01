//
//  HomeViewController.swift
//  BookShelf
//
//  Created by Aditya Krishna on 4/28/22.
//

import UIKit

class HomeViewController: UITabBarController {
    var appNavigation: AppNavigationController!
    var profileViewController: ProfileViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setupViewControllers()
    }
    
    private func setupViewControllers() {
        setupNavigationController()
        setupProfileViewController()
        
        viewControllers = [appNavigation, profileViewController]
    }
    
    private func setupNavigationController() {
        appNavigation = AppNavigationController()
        appNavigation.tabBarItem = UITabBarItem(tabBarSystemItem: .featured, tag: 0)
    }
    
    private func setupProfileViewController() {
        profileViewController = UIViewController.profileViewController()
        profileViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .contacts, tag: 1)
    }
}
