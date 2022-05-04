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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setupCollectionView()
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
        
        // TODO: Setup cell
        let product = viewModel.products[indexPath.item]
        cell.bookImageView.kf.setImage(with: URL(string: product.image ?? ""))
        cell.titleLabel.text = product.name
        cell.ratingsLabel.text = product.rating != nil ? String(product.rating ?? 0) : "NA"
        cell.priceLabel.text = product.price != nil ? String(product.price ?? 0) : "NA"
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.navigationController?.pushViewController(UIViewController.bookDetailsViewController(), animated: true)
    }
}
