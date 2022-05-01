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
    }
    
    private func setupTableView() {
        profileOrdersTableView.register(UINib(nibName: "ProfileOrderTableViewCell", bundle: nil), forCellReuseIdentifier: "ProfileOrderTableViewCell")
        profileOrdersTableView.delegate = self
        profileOrdersTableView.dataSource = self
    }
    
    private func setTableViewHeight() {
        profileOrdersTableViewHeightConstraint.constant = CGFloat(profileOrdersTableView.numberOfRows(inSection: 0)) * ProfileOrderTableViewCell.CELL_HEIGHT
    }
}

// MARK: - @IBAction methods
extension ProfileViewController {
    @IBAction func didTapUpdate(_ sender: Any) {
        
    }
}

// MARK: - TableViewDelegate and TableViewDataSource methods
extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // TODO: Return number of cells
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileOrderTableViewCell", for: indexPath) as? ProfileOrderTableViewCell else {
            fatalError("Could not dequeue cell")
        }
        
        // TODO: Set cell details
        
        return cell
    }
}
