//
//  UIView.swift
//  BookShelf
//
//  Created by Aditya Krishna on 5/1/22.
//

import UIKit

extension UIView {
    func addShadow(withRadius radius: CGFloat = 8) {
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 1
        self.layer.shadowOffset = .zero
        self.layer.shadowRadius = radius
    }
}
