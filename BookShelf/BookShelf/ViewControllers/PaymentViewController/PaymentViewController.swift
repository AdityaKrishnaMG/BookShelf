//
//  PaymentViewController.swift
//  BookShelf
//
//  Created by Aditya Krishna on 5/2/22.
//

import UIKit

class PaymentViewController: UIViewController {
    @IBOutlet weak var payPalButton: UIButton!
    @IBOutlet weak var creditCardButton: UIButton!
    @IBOutlet weak var debitCardButton: UIButton!
    @IBOutlet weak var continueButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
}

// MARK: - @IBAction methods
extension PaymentViewController {
    @IBAction func didTapPayPal(_ sender: Any) {
        
    }
    
    @IBAction func didTapCreditCard(_ sender: Any) {
        
    }
    
    @IBAction func didTapDebitCard(_ sender: Any) {
        
    }
    
    @IBAction func didTapContinue(_ sender: Any) {
        self.navigationController?.pushViewController(UIViewController.summaryViewController(), animated: true)
    }
}
