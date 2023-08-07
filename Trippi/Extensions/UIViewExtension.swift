//
//  UIViewExtension.swift
//  Trippi
//
//  Created by macmini50 on 07/08/23.
//

import UIKit

extension UIView {
    func addShadow(color: CGColor, opacity: Float, offset: CGSize, radius: Double) {
        self.layer.shadowColor = color
        self.layer.shadowOffset = offset
        self.layer.shadowRadius = radius
        self.layer.shadowOpacity = opacity
    }
}
