//
//  BookDetailsViewController.swift
//  BookShelf
//
//  Created by Aditya Krishna on 5/1/22.
//

import UIKit
import Kingfisher

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
    
    var viewModel: BookDetailsViewModel!
    
    weak var delegate: BookDetailsViewControllerDelegate?
    
    var ratingPicker: UIPickerView!
    var textFieldToolBar: UIToolbar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setupTableView()
        setupPicker()
        setupTextFields()
        setupTextView()
        setupToolBar()
        setupCallbacks()
        viewModel.getData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        bookImageViewContainerView.addShadow(withRadius: 4, shadowColor: UIColor(red: 1/255, green: 25/255, blue: 54/255, alpha: 1), shadowOpacity: 0.7, shadowOffset: .zero, cornerRadius: 4)
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
    
    private func setupTextView() {
        reviewTextView.delegate = self
        reviewTextView.addBorder(with: .lightGray, cornerRadius: 4, borderWidth: 0.5)
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
    
    private func setupCallbacks() {
        viewModel.didFetchData = { [weak self ] in
            self?.setupDataFields()
        }
        
        viewModel.didFetchDataFailed = { [weak self ] error in
            self?.showAlert(with: error)
        }
        
        viewModel.didAddReview = {
            
        }
        
        viewModel.didAddReviewFail = { [weak self ] error in
            self?.showAlert(with: error)
        }
    }
    
    private func setupDataFields() {
        guard let product = viewModel.productDetails else {
            return
        }
        
        bookImageView.kf.setImage(with: URL(string: product.image ?? ""))
        titleLabel.text = product.name
        ratingLabel.text = String(product.rating ?? 0)
        priceLabel.text = "$\(String(product.price ?? 0))"
        descriptionLabel.text = product.description
        statusLabel.text = String(product.countInStock ?? 0)
        
        reviewsTableView.reloadData()
        setTableViewHeight()
        
    }
}

// MARK: - @IBAction methods
extension BookDetailsViewController {
    @IBAction func didTapAddToCart(_ sender: Any) {
        guard let details = viewModel.productDetails else {
            return
        }
        
        delegate?.bookDetailsViewController(self, didTapAddToCart: details)
    }
    
    @IBAction func didTapPostReview(_ sender: Any) {
        viewModel.addReview()
    }
}

// MARK: - UITableViewDelegate and UITableViewDataSource methods
extension BookDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.productDetails?.reviews?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ReviewsTableViewCell", for: indexPath) as? ReviewsTableViewCell else {
            fatalError("Could not dequeue reusable cell")
        }
        
        let review = viewModel.productDetails?.reviews?[indexPath.row]
        cell.userNameLabel.text = review?.name
        cell.reviewLabel.text = review?.comment
        
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
            viewModel.productDetails?.qty = Int(text)
        } else if ratingTextField.isFirstResponder {
            ratingTextField.text = text
        }
    }
}

extension BookDetailsViewController: UITextViewDelegate {
    func textViewDidEndEditing(_ textView: UITextView) {
        let review = Review(rating: Double(ratingTextField.text ?? "5"), comment: textView.text)
        viewModel.review = review
    }
}

protocol BookDetailsViewControllerDelegate: AnyObject {
    func bookDetailsViewController(_ bookDetailsViewController: BookDetailsViewController, didTapAddToCart book: ProductDetails)
}
