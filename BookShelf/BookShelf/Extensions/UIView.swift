//
//  UIView.swift
//  BookShelf
//
//  Created by Aditya Krishna on 5/1/22.
//

import UIKit

extension UIView {
    func addShadow(withRadius radius: CGFloat = 5, shadowColor: UIColor = .darkGray, shadowOpacity: Float = 0.5, shadowOffset: CGSize = .zero, cornerRadius: CGFloat = 5) {
        layer.masksToBounds = false
        layer.shadowColor = shadowColor.cgColor
        layer.shadowOpacity = shadowOpacity
        layer.shadowOffset = shadowOffset
        layer.shadowRadius = radius
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = UIScreen.main.scale
    }
    
    func roundenCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
    
    func rounden(with radius: CGFloat) {
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
    }
    
    func addBorder(with color: UIColor?, cornerRadius: CGFloat, borderWidth: CGFloat) {
        self.layer.cornerRadius = cornerRadius
        self.layer.borderColor = color?.cgColor ?? self.backgroundColor?.cgColor
        self.layer.borderWidth = borderWidth
    }
}
