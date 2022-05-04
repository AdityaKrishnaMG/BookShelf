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
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
}

// MARK: - @IBAction methods
extension SummaryViewController {
    @IBAction func didTapConfirmOrder(_ sender: Any) {
        
    }
}
