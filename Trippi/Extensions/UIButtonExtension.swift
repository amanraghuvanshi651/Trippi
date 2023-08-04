//
//  AnimateButton.swift
//  Trippi
//
//  Created by Aman Raghuvanshi on 03/08/23.
//

import UIKit

extension UIButton {
    func bounceAnimation(bounceScale: Double) {
        UIView.animate(withDuration: 0.5) { [weak self] in
            guard let self = self else { return }
            self.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
            UIView.animate(withDuration: 2.0,
                           delay: 0,
                           usingSpringWithDamping: 0.2,
                           initialSpringVelocity: 6.0,
                           options: .allowUserInteraction,
                           animations: { [weak self] in
                guard let self = self else { return }
                self.transform = .identity
            },completion: nil)
        }
    }
}
