//
//  BookListViewController.swift
//  BookShelf
//
//  Created by Aditya Krishna on 5/1/22.
//

import UIKit
import Kingfisher

class BookListViewController: UIViewController {
    @IBOutlet weak var booksCollectionView: UICollectionView!
    
    var viewModel: BookListViewModel = BookListViewModelImp()
    
    weak var delegate: BookListViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setupCollectionView()
        setupCallbacks()
        viewModel.getData()
    }
    
    private func setupCollectionView() {
        booksCollectionView.register(UINib(nibName: "BookCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "BookCollectionViewCell")
        booksCollectionView.delegate = self
        booksCollectionView.dataSource = self
    }
    
    private func setupCallbacks() {
        viewModel.didFetchData = { [weak self] in
            self?.booksCollectionView.reloadData()
        }
        
        viewModel.didFetchDataFailed = { [weak self] errorDescription in
            self?.showAlert(with: errorDescription)
        }
    }
}

// MARK: - UICollectionViewDelegate and UICollectionViewDataSource methods
extension BookListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BookCollectionViewCell", for: indexPath) as? BookCollectionViewCell else {
            fatalError("Could not dequeue cell")
        }
        
        let product = viewModel.products[indexPath.item]
        cell.bookImageView.kf.setImage(with: URL(string: product.image ?? ""))
        cell.titleLabel.text = product.name
        cell.ratingsLabel.text = product.rating != nil ? String(product.rating ?? 0) : "NA"
        cell.priceLabel.text = product.price != nil ? String(product.price ?? 0) : "NA"
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let id = viewModel.products[indexPath.item].id else {
            return
        }
        
        let viewController = UIViewController.bookDetailsViewController(bookId: id)
        viewController.delegate = self
        
        self.navigationController?.pushViewController(viewController, animated: true)
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

extension BookListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: 300, height: BookCollectionViewCell.CELL_HEIGHT*1.5)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        20
    }
}

extension BookListViewController: BookDetailsViewControllerDelegate {
    func bookDetailsViewController(_ bookDetailsViewController: BookDetailsViewController, didTapAddToCart book: ProductDetails) {
        delegate?.bookListViewController(self, didAddBook: book)
    }
}

protocol BookListViewControllerDelegate: AnyObject {
    func bookListViewController(_ bookListViewController: BookListViewController, didAddBook book: ProductDetails)
}
