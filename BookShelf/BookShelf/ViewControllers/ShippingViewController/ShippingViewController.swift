//
//  ShippingViewController.swift
//  BookShelf
//
//  Created by Aditya Krishna on 5/1/22.
//

import UIKit

class ShippingViewController: ViewController {
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var zipTextField: UITextField!
    @IBOutlet weak var countryTextField: UITextField!
    
    @IBOutlet weak var paymentButton: UIButton!
    
    var viewModel: ShippingViewModel!
    
    weak var delegate: ShippingViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    private func setupTextFields() {
        addressTextField.delegate = self
        cityTextField.delegate = self
        zipTextField.delegate = self
        countryTextField.delegate = self
    }
}

// MARK: - @IBAction methods
extension ShippingViewController {
    @IBAction func didTapPayment(_ sender: Any) {
        let viewController = UIViewController.paymentViewController(cartDetails: viewModel.cartDetails)
        viewController.delegate = self
        
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}

// MARK: - UITextFieldDelegate methods
extension ShippingViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        let text = textField.text
        switch textField {
        case addressTextField:
            viewModel.cartDetails.address = text
        case cityTextField:
            viewModel.cartDetails.city = text
        case zipTextField:
            viewModel.cartDetails.postalCode = text
        case countryTextField:
            viewModel.cartDetails.country = text
        default:
            fatalError("TextField not handled")
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        var text = textField.text ?? ""
        
        if string.isEmpty {
            text.removeLast()
        } else {
            text = text + string
        }
        
        switch textField {
        case addressTextField:
            viewModel.cartDetails.address = text
        case cityTextField:
            viewModel.cartDetails.city = text
        case zipTextField:
            viewModel.cartDetails.postalCode = text
        case countryTextField:
            viewModel.cartDetails.country = text
        default:
            fatalError("TextField not handled")
        }
        
        return true
    }
}

extension ShippingViewController: PaymentViewControllerDelegate {
    func paymentViewControllerDidConfirmOrder(_ paymentViewController: PaymentViewController) {
        delegate?.shippingViewControllerDidConfirmOrder(self)
    }
}

protocol ShippingViewControllerDelegate: AnyObject {
    func shippingViewControllerDidConfirmOrder(_ shippingViewController: ShippingViewController)
}
