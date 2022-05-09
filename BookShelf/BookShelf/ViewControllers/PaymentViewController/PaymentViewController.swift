//
//  PaymentViewController.swift
//  BookShelf
//
//  Created by Aditya Krishna on 5/2/22.
//

import UIKit

class PaymentViewController: ViewController {
    @IBOutlet weak var payPalButton: UIButton!
    @IBOutlet weak var creditCardButton: UIButton!
    @IBOutlet weak var debitCardButton: UIButton!
    @IBOutlet weak var continueButton: UIButton!
    
    var viewModel: PaymentViewModel!
    
    weak var delegate: PaymentViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
}

// MARK: - @IBAction methods
extension PaymentViewController {
    @IBAction func didTapPayPal(_ sender: Any) {
        viewModel.cartDetails.paymentMethod = PaymentType.payPal.rawValue
        changeButtonImage(payPalButton, filled: true)
        changeButtonImage(creditCardButton, filled: false)
        changeButtonImage(debitCardButton, filled: false)
    }
    
    @IBAction func didTapCreditCard(_ sender: Any) {
        viewModel.cartDetails.paymentMethod = PaymentType.creditCard.rawValue
        changeButtonImage(payPalButton, filled: false)
        changeButtonImage(creditCardButton, filled: true)
        changeButtonImage(debitCardButton, filled: false)
    }
    
    @IBAction func didTapDebitCard(_ sender: Any) {
        viewModel.cartDetails.paymentMethod = PaymentType.debitCard.rawValue
        changeButtonImage(payPalButton, filled: false)
        changeButtonImage(creditCardButton, filled: false)
        changeButtonImage(debitCardButton, filled: true)
    }
    
    @IBAction func didTapContinue(_ sender: Any) {
        let viewController = UIViewController.summaryViewController(cartDetails: viewModel.cartDetails)
        viewController.delegate = self
        
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    private func changeButtonImage(_ button: UIButton, filled: Bool) {
        UIView.transition(with: button, duration: Constants.AnimationDuration.SHORT) {
            button.setImage(filled ? UIImage(systemName: "circle.inset.filled") : UIImage(systemName: "circle"), for: .normal)
        }
    }
}

extension PaymentViewController: SummaryViewControllerDelegate {
    func summaryViewControllerDidConfirmOrder(_ summaryViewController: SummaryViewController) {
        delegate?.paymentViewControllerDidConfirmOrder(self)
    }
}

protocol PaymentViewControllerDelegate: AnyObject {
    func paymentViewControllerDidConfirmOrder(_ paymentViewController: PaymentViewController)
}
