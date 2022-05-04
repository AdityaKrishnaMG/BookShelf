//
//  ShippingViewController.swift
//  BookShelf
//
//  Created by Aditya Krishna on 5/1/22.
//

import UIKit

class ShippingViewController: UIViewController {
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var zipTextField: UITextField!
    @IBOutlet weak var countryTextField: UITextField!
    
    @IBOutlet weak var paymentButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
}

// MARK: - @IBAction methods
extension ShippingViewController {
    @IBAction func didTapPayment(_ sender: Any) {
        self.navigationController?.pushViewController(UIViewController.paymentViewController(), animated: true)
    }
}
