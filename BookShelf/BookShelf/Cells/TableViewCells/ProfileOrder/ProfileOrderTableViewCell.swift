//
//  ProfileOrderTableViewCell.swift
//  BookShelf
//
//  Created by Aditya Krishna on 5/1/22.
//

import UIKit

class ProfileOrderTableViewCell: UITableViewCell {
    static let CELL_HEIGHT: CGFloat = 54
    
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
        orderIdLabel.text = "ID: \(id ?? "NA")"
    }
    
    func setOrderDate(date: String?) {
        orderDateLabel.text = "Date: \(date ?? "NA")"
    }
    
    func setOrderTotal(total: String?) {
        orderTotalLabel.text = "Total: \(total ?? "NA")"
    }
    
    func setOrderPaymentStatus(status: String?) {
        orderPaymentStatusLabel.text = "Payment: \(status ?? "NA")"
    }
    
    func setOrderDeliveryStatus(status: String?) {
        orderDeliveryLabel.text = "Order: \(status ?? "NA")"
    }
}
