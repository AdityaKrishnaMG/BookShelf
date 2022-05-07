//
//  CartBooksCollectionViewCell.swift
//  BookShelf
//
//  Created by Aditya Krishna on 5/1/22.
//

import UIKit

class CartBooksCollectionViewCell: UICollectionViewCell {
    static let CELL_HEIGHT: CGFloat = 236
    
    @IBOutlet weak var bookImageViewContainerView: UIView!
    @IBOutlet weak var bookImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var quantityTextField: UITextField!
    @IBOutlet weak var deleteButton: UIButton!
    
    weak var delegate: CartBooksCollectionViewCellDelegate?
    
    var ratingPicker: UIPickerView!
    var textFieldToolBar: UIToolbar!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupPicker()
        setupToolBar()
        setupTextFields()
    }
    
    private func setupPicker() {
        ratingPicker = UIPickerView()
        ratingPicker.delegate = self
        ratingPicker.dataSource = self
    }
    
    private func setupTextFields() {
        quantityTextField.inputView = ratingPicker
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
    }
    
    @objc private func didTapDone() {
        quantityTextField.resignFirstResponder()
    }
}

// MARK: - @IBAction methods
extension CartBooksCollectionViewCell {
    @IBAction func didTapDelete(_ sender: Any) {
        delegate?.cartBooksCollectionViewCellDidTapDelete(self)
    }
}

// MARK: - UIPickerViewDelegate and UIPickerViewDataSource methods
extension CartBooksCollectionViewCell: UIPickerViewDelegate, UIPickerViewDataSource {
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
        quantityTextField.text = text
        delegate?.cartBooksCollectionViewCell(self, didChangeRating: text)
    }
}

protocol CartBooksCollectionViewCellDelegate: AnyObject {
    func cartBooksCollectionViewCell(_ cartBooksCollectionViewCell: CartBooksCollectionViewCell, didChangeRating rating: String)
    func cartBooksCollectionViewCellDidTapDelete(_ cartBooksCollectionViewCell: CartBooksCollectionViewCell)
}
