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
        viewControllers = [UIViewController.homeViewController()]
        
        self.navigationBar.backgroundColor = UIColor(red: 1/255, green: 25/255, blue: 54/255, alpha: 1)
        self.navigationBar.tintColor = UIColor(red: 255/255, green: 107/255, blue: 107/255, alpha: 1)
        self.addStatusBarBackground(with: UIColor(red: 1/255, green: 25/255, blue: 54/255, alpha: 1))
    }
}
