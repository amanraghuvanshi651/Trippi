//
//  UIViewExtension.swift
//  Trippi
//
//  Created by Aman Raghuvanshi on 07/08/23.
//

import UIKit

extension UIView {
    func addShadow(color: CGColor, opacity: Float, offset: CGSize, radius: Double) {
        self.layer.shadowColor = color
        self.layer.shadowOffset = offset
        self.layer.shadowRadius = radius
        self.layer.shadowOpacity = opacity
    }
    
    func drawDottedLine() {
        let shapeLayer = CAShapeLayer()
        shapeLayer.strokeColor = UIColor(named: BUTTON_TEXT_COLOR)?.cgColor
        shapeLayer.lineWidth = 1
        shapeLayer.lineDashPattern = [7, 3] // 7 is the length of dash, 3 is length of the gap.

        let path = CGMutablePath()
        path.addLines(between: [CGPoint(x: self.bounds.minX, y: self.bounds.midY), CGPoint(x: self.bounds.maxX, y: self.bounds.midY)])
        shapeLayer.path = path
        self.layer.insertSublayer(shapeLayer, at: 0)
//        self.layer.addSublayer(shapeLayer)
    }
}
