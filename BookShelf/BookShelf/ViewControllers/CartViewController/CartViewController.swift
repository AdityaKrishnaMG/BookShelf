//
//  CartViewController.swift
//  BookShelf
//
//  Created by Aditya Krishna on 5/1/22.
//

import UIKit

class CartViewController: ViewController {
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var scrollViewContainerView: UIView!
    @IBOutlet weak var booksCollectionView: UICollectionView!
    @IBOutlet weak var booksCollectionViewHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var priceDetailsContainerView: UIView!
    @IBOutlet weak var priceLabel: UILabel!
    
    @IBOutlet weak var checkoutButton: UIButton!
    
    var viewModel: CartViewModel = CartViewModelImp()
    
    weak var delegate: CartViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setupCollectionView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setCollectionViewHeight()
        setupDataFields()
//        priceDetailsContainerView.addShadow(withRadius: 4, shadowColor: .lightGray, shadowOpacity: 0.7, shadowOffset: .zero, cornerRadius: 4)
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
        UIView.animate(withDuration: Constants.AnimationDuration.SHORT) {
            self.booksCollectionView.layoutIfNeeded()
        }

    }
    
    private func setupDataFields() {
        priceLabel.text = "$" + String(viewModel.cartDetails.totalPrice ?? 0)
    }
}

// MARK: - @IBAction methods
extension CartViewController {
    @IBAction func didTapCheckout(_ sender: Any) {
        let viewController = UIViewController.shippingViewController(cartDetails: viewModel.cartDetails)
        viewController.delegate = self
        
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}

// MARK: - UICollectionViewDelegate and UICollectionViewDataSource methods
extension CartViewController: UICollectionViewDelegate, UICollectionViewDataSource {
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
        cell.delegate = self
        
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
//        cell.layer.shadowColor = UIColor.darkGray.cgColor
        cell.layer.shadowColor = UIColor(red: 1/255, green: 25/255, blue: 54/255, alpha: 1).cgColor
        cell.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        cell.layer.shadowRadius = 6
        cell.layer.shadowOpacity = 0.5
        cell.layer.masksToBounds = false
        cell.layer.shadowPath = UIBezierPath(roundedRect: cell.bounds, cornerRadius: cell.contentView.layer.cornerRadius).cgPath
    }
}

extension CartViewController: UICollectionViewDelegateFlowLayout {
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

extension CartViewController: ShippingViewControllerDelegate {
    func shippingViewControllerDidConfirmOrder(_ shippingViewController: ShippingViewController) {
        delegate?.cartViewControllerDidConformOrder(self)
    }
}

extension CartViewController: CartBooksCollectionViewCellDelegate {
    func cartBooksCollectionViewCell(_ cartBooksCollectionViewCell: CartBooksCollectionViewCell, didChangeRating rating: String) {
        guard let index = booksCollectionView.indexPath(for: cartBooksCollectionViewCell)?.item else {
            return
        }
        
        viewModel.cartDetails.orderItems?[index].qty = Int(rating)
    }
    
    func cartBooksCollectionViewCellDidTapDelete(_ cartBooksCollectionViewCell: CartBooksCollectionViewCell) {
        guard let index = booksCollectionView.indexPath(for: cartBooksCollectionViewCell)?.item else {
            return
        }
        
        viewModel.cartDetails.orderItems?.remove(at: index)
        booksCollectionView.deleteItems(at: [IndexPath(item: index, section: 0)])
        setCollectionViewHeight()
    }
}

protocol CartViewControllerDelegate: AnyObject {
    func cartViewControllerDidConformOrder(_ cartViewController: CartViewController)
}
