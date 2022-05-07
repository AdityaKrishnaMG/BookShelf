//
//  SummaryViewController.swift
//  BookShelf
//
//  Created by Aditya Krishna on 5/1/22.
//

import UIKit

class SummaryViewController: UIViewController {
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var scrollViewContainerView: UIView!
    @IBOutlet weak var booksCollectionView: UICollectionView!
    @IBOutlet weak var booksCollectionViewHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var priceDetailsContainerView: UIView!
    
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var shippingLabel: UILabel!
    @IBOutlet weak var totalAmountLabel: UILabel!
    
    @IBOutlet weak var confirmOrderButton: UIButton!
    
    var viewModel: SummaryViewModel!
    
    weak var delegate: SummaryViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setupCollectionView()
        setupCallbacks()
        setupDataFields()
        setCollectionViewHeight()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setCollectionViewHeight()
    }
    
    private func setupCallbacks() {
        viewModel.didFetchData = { [weak self ] in
            guard let self = self else {
                return
            }
            
            self.delegate?.summaryViewControllerDidConfirmOrder(self)
        }
        
        viewModel.didFetchDataFailed = { [weak self ] error in
            self?.showAlert(with: error)
        }
    }
    
    private func setupDataFields() {
        priceLabel.text = String(viewModel.cartDetails.itemsPrice ?? 0)
        shippingLabel.text = String(viewModel.cartDetails.shippingPrice ?? 9)
        totalAmountLabel.text = String(viewModel.cartDetails.totalPrice ?? 0)
    }
    
    private func setupCollectionView() {
        booksCollectionView.register(UINib(nibName: "CartBooksCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CartBooksCollectionViewCell")
        booksCollectionView.delegate = self
        booksCollectionView.dataSource = self
    }

    private func setCollectionViewHeight() {
        booksCollectionView.reloadData()
        booksCollectionView.layoutIfNeeded()
        booksCollectionViewHeightConstraint.constant = booksCollectionView.contentSize.height
    }
}

// MARK: - @IBAction methods
extension SummaryViewController {
    @IBAction func didTapConfirmOrder(_ sender: Any) {
        viewModel.confirmOrder()
    }
}

// MARK: - UICollectionViewDelegate and UICollectionViewDataSource methods
extension SummaryViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.cartDetails.orderItems?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CartBooksCollectionViewCell", for: indexPath) as? CartBooksCollectionViewCell else {
            fatalError("Could not dequeue cell")
        }
        
        let product = viewModel.cartDetails.orderItems?[indexPath.item]
        cell.bookImageView.kf.setImage(with: URL(string: product?.image ?? ""))
        cell.titleLabel.text = product?.name
        cell.titleLabel.sizeToFit()
        cell.quantityTextField.text = String(product?.qty ?? 0)
        cell.quantityTextField.isEnabled = false
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        addCellShadow(cell: cell)
    }
    
    private func addCellShadow(cell: UICollectionViewCell) {
        cell.contentView.layer.cornerRadius = 6.0
        cell.contentView.layer.borderWidth = 1.0
        cell.contentView.layer.borderColor = UIColor.clear.cgColor
        cell.contentView.layer.masksToBounds = true
        cell.layer.shadowColor = UIColor.darkGray.cgColor
        cell.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        cell.layer.shadowRadius = 6
        cell.layer.shadowOpacity = 0.5
        cell.layer.masksToBounds = false
        cell.layer.shadowPath = UIBezierPath(roundedRect: cell.bounds, cornerRadius: cell.contentView.layer.cornerRadius).cgPath
    }
}

extension SummaryViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: 300, height: CartBooksCollectionViewCell.CELL_HEIGHT*1.5)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        20
    }
}

protocol SummaryViewControllerDelegate: AnyObject {
    func summaryViewControllerDidConfirmOrder(_ summaryViewController: SummaryViewController)
}
