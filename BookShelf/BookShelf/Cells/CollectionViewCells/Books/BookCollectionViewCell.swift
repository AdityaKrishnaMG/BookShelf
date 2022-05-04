//
//  BookCollectionViewCell.swift
//  BookShelf
//
//  Created by Aditya Krishna on 5/1/22.
//

import UIKit

class BookCollectionViewCell: UICollectionViewCell {
    static let CELL_HEIGHT: CGFloat = 231
    
    @IBOutlet weak var bookImageViewContainerView: UIView!
    @IBOutlet weak var bookImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var ratingsLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setImageViewContainerShadow()
    }
    
    private func setImageViewContainerShadow() {
        bookImageViewContainerView.addShadow()
    }
}
