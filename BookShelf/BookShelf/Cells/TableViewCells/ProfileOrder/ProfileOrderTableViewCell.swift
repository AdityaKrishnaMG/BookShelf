//
//  ProfileOrderTableViewCell.swift
//  BookShelf
//
//  Created by Aditya Krishna on 5/1/22.
//

import UIKit

class ProfileOrderTableViewCell: UITableViewCell {
    static let CELL_HEIGHT: CGFloat = 72
    
    @IBOutlet weak var orderIdLabel: UILabel!
    @IBOutlet weak var orderDateLabel: UILabel!
    @IBOutlet weak var orderTotalLabel: UILabel!
    @IBOutlet weak var orderPaymentStatusLabel: UILabel!
    @IBOutlet weak var orderDeliveryLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func setOrderId(id: String?) {
        orderIdLabel.text = id ?? "Not Available"
    }
    
    func setOrderDate(date: String?) {
        orderDateLabel.text = date ?? "Not Available"
    }
    
    func setOrderTotal(total: String?) {
        orderTotalLabel.text = "$" + (total ?? "Not Available")
    }
    
    func setOrderPaymentStatus(status: String?) {
        orderPaymentStatusLabel.text = status ?? "Not Available"
    }
    
    func setOrderDeliveryStatus(status: String?) {
        orderDeliveryLabel.text = status ?? "Not Available"
    }
}
