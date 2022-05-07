//
//  LoginViewController.swift
//  BookShelf
//
//  Created by Aditya Krishna on 4/28/22.
//

import UIKit

class LoginViewController: ViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    var viewModel: LoginViewModel = LoginViewModelImp()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupCallbacks()
        setupTextFields()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        UIApplication.shared.windows.first?.rootViewController = UIViewController.homeViewController()
//        UIApplication.shared.windows.first?.makeKeyAndVisible()
    }
    
    private func setupCallbacks() {
        viewModel.didFetchDetails = {
            UIApplication.shared.windows.first?.rootViewController = AppNavigationController()
            UIApplication.shared.windows.first?.makeKeyAndVisible()
        }
        
        viewModel.didFetchDetailsFailed = { error in
            self.showAlert(with: error)
        }
    }
    
    private func setupTextFields() {
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }
}

// MARK: - @IBAction methods
extension LoginViewController {
    @IBAction func didTapLogin(_ sender: Any) {
        guard !(viewModel.details.email?.isEmpty ?? true) && !(viewModel.details.password?.isEmpty ?? true) else {
            return
        }
        viewModel.login()
    }
    
    @IBAction func didTapRegister(_ sender: Any) {
        
    }
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        let text = textField.text
        if textField == emailTextField {
            viewModel.details.email = text
        } else {
            viewModel.details.password = text
        }
    }
}
