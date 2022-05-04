//
//  CartViewController.swift
//  BookShelf
//
//  Created by Aditya Krishna on 5/1/22.
//

import UIKit

class CartViewController: UIViewController {
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var scrollViewContainerView: UIView!
    @IBOutlet weak var booksCollectionView: UICollectionView!
    @IBOutlet weak var booksCollectionViewHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var priceDetailsContainerView: UIView!
    @IBOutlet weak var priceLabel: UILabel!
    
    @IBOutlet weak var checkoutButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setupCollectionView()
    }
    
    private func setupCollectionView() {
        booksCollectionView.register(UINib(nibName: "CartBooksCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CartBooksCollectionViewCell")
        booksCollectionView.delegate = self
        booksCollectionView.dataSource = self
    }
}

// MARK: - @IBAction methods
extension CartViewController {
    @IBAction func didTapCheckout(_ sender: Any) {
        self.navigationController?.pushViewController(UIViewController.shippingViewController(), animated: true)
    }
}

// MARK: - UICollectionViewDelegate and UICollectionViewDataSource methods
extension CartViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // TODO: Return number of items
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CartBooksCollectionViewCell", for: indexPath) as? CartBooksCollectionViewCell else {
            fatalError("Could not dequeue cell")
        }
        
        // TODO: Setup cell
        
        return cell
    }
}
