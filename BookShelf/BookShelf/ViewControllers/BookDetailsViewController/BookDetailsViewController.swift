//
//  BookDetailsViewController.swift
//  BookShelf
//
//  Created by Aditya Krishna on 5/1/22.
//

import UIKit

class BookDetailsViewController: UIViewController {
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var scrollViewContainerView: UIView!
    
    @IBOutlet weak var bookImageViewContainerView: UIView!
    @IBOutlet weak var bookImageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var quantityTextField: UITextField!
    @IBOutlet weak var addToCartButton: UIButton!
    
    @IBOutlet weak var reviewsTableView: UITableView!
    @IBOutlet weak var reviewsTableViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var ratingTextField: UITextField!
    @IBOutlet weak var reviewTextView: UITextView!
    @IBOutlet weak var postReviewButton: UIButton!
    
    var ratingPicker: UIPickerView!
    var textFieldToolBar: UIToolbar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setupTableView()
        setupPicker()
        setupTextFields()
        setupToolBar()
    }
    
    private func setupTableView() {
        reviewsTableView.register(UINib(nibName: "ReviewsTableViewCell", bundle: nil), forCellReuseIdentifier: "ReviewsTableViewCell")
        reviewsTableView.delegate = self
        reviewsTableView.dataSource = self
    }
    
    private func setTableViewHeight() {
        reviewsTableView.reloadData()
        reviewsTableViewHeightConstraint.constant = reviewsTableView.contentSize.height
        UIView.animate(withDuration: Constants.AnimationDuration.SHORT) {
            self.scrollViewContainerView.layoutIfNeeded()
        }
    }
    
    private func setupPicker() {
        ratingPicker = UIPickerView()
        ratingPicker.delegate = self
        ratingPicker.dataSource = self
    }
    
    private func setupTextFields() {
        quantityTextField.inputView = ratingPicker
        ratingTextField.inputView = ratingPicker
    }
    
    private func setupToolBar() {
        let toolBar = UIToolbar()
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(didTapDone))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolBar.setItems([spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        textFieldToolBar = toolBar
        quantityTextField.inputAccessoryView = toolBar
        ratingTextField.inputAccessoryView = toolBar
    }
    
    @objc private func didTapDone() {
        quantityTextField.resignFirstResponder()
        ratingTextField.resignFirstResponder()
    }
}

// MARK: - @IBAction methods
extension BookDetailsViewController {
    @IBAction func didTapAddToCart(_ sender: Any) {
        
    }
    
    @IBAction func didTapPostReview(_ sender: Any) {
        
    }
}

// MARK: - UITableViewDelegate and UITableViewDataSource methods
extension BookDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // TODO: Return rows count
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ReviewsTableViewCell", for: indexPath) as? ReviewsTableViewCell else {
            fatalError("Could not dequeue reusable cell")
        }
        
        // TODO: Setup cell
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        54
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
}

// MARK: - UIPickerViewDelegate and UIPickerViewDataSource methods
extension BookDetailsViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        5
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        String(row + 1)
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let text = String(row + 1)
        if quantityTextField.isFirstResponder {
            quantityTextField.text = text
        } else if ratingTextField.isFirstResponder {
            ratingTextField.text = text
        }
    }
}
