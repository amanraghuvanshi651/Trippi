//
//  ButtonVibration.swift
//  Trippi
//
//  Created by Aman Raghuvanshi on 03/08/23.
//

import UIKit

protocol HasButtonVibration {
    func mediumVibration()
    func heavyVibration()
}

extension HasButtonVibration where Self: UIViewController {
    func mediumVibration() {
        UIImpactFeedbackGenerator(style: .medium).impactOccurred()
    }
    
    func heavyVibration() {
        UIImpactFeedbackGenerator(style: .heavy).impactOccurred()
    }
}

extension HasButtonVibration where Self: UICollectionViewCell {
    func mediumVibration() {
        UIImpactFeedbackGenerator(style: .medium).impactOccurred()
    }
    
    func heavyVibration() {
        UIImpactFeedbackGenerator(style: .medium).impactOccurred()
    }
}

extension HasButtonVibration where Self: UITableViewCell {
    func mediumVibration() {
        UIImpactFeedbackGenerator(style: .medium).impactOccurred()
    }
    
    func heavyVibration() {
        UIImpactFeedbackGenerator(style: .medium).impactOccurred()
    }
}
