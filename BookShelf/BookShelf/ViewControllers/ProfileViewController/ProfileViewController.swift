//
//  ProfileViewController.swift
//  BookShelf
//
//  Created by Aditya Krishna on 4/28/22.
//

import UIKit

class ProfileViewController: ViewController {
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var updateButton: UIButton!
    
    @IBOutlet weak var profileOrdersTableView: UITableView!
    @IBOutlet weak var profileOrdersTableViewHeightConstraint: NSLayoutConstraint!
    
    var viewModel: ProfileViewModel = ProfileViewModelImp()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setupTableView()
        setupCallbacks()
        setupDataFields()
        viewModel.getOrders()
    }
    
    private func setupTableView() {
        profileOrdersTableView.register(UINib(nibName: "ProfileOrderTableViewCell", bundle: nil), forCellReuseIdentifier: "ProfileOrderTableViewCell")
        profileOrdersTableView.delegate = self
        profileOrdersTableView.dataSource = self
    }
    
    private func setTableViewHeight() {
        profileOrdersTableViewHeightConstraint.constant = CGFloat(profileOrdersTableView.numberOfRows(inSection: 0)) * ProfileOrderTableViewCell.CELL_HEIGHT
    }
    
    private func setupCallbacks() {
        viewModel.didUpdateDetails = { [ weak self ] in
            self?.showMessageAlert(with: Strings.UPDATE_SUCCESSFUL)
        }
        
        viewModel.didUpdateDetailsFailed = { [ weak self ] error in
            self?.showAlert(with: error)
        }
        
        viewModel.didFetchDetails = { [weak self ] in
            self?.profileOrdersTableView.reloadData()
            self?.setTableViewHeight()
        }
        
        viewModel.didFetchDetailsFailed = { [ weak self ] error in
            self?.showAlert(with: error)
        }
    }
    
    private func setupDataFields() {
        nameTextField.text = Authorization.shared.userDetails.name
        emailTextField.text = Authorization.shared.userDetails.email
    }
}

// MARK: - @IBAction methods
extension ProfileViewController {
    @IBAction func didTapUpdate(_ sender: Any) {
        viewModel.updateUser()
    }
}

// MARK: - TableViewDelegate and TableViewDataSource methods
extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.orders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileOrderTableViewCell", for: indexPath) as? ProfileOrderTableViewCell else {
            fatalError("Could not dequeue cell")
        }
        
        let order = viewModel.orders[indexPath.row]
        cell.setOrderId(id: order.id)
        cell.setOrderDate(date: order.deliveredAt)
        cell.setOrderTotal(total: String(order.totalPrice ?? 0))
        cell.setOrderDeliveryStatus(status: (order.delivered ?? false) ? Strings.COMPLETED : Strings.PENDING)
        cell.setOrderPaymentStatus(status: (order.paid ?? false) ? Strings.COMPLETED : Strings.PENDING)
        
        return cell
    }
}
