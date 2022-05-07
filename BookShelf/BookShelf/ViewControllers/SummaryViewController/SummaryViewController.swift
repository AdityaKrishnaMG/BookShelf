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
        
        setupCallbacks()
        setupDataFields()
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
}

// MARK: - @IBAction methods
extension SummaryViewController {
    @IBAction func didTapConfirmOrder(_ sender: Any) {
        viewModel.confirmOrder()
    }
}

protocol SummaryViewControllerDelegate: AnyObject {
    func summaryViewControllerDidConfirmOrder(_ summaryViewController: SummaryViewController)
}
