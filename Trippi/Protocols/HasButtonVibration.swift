//
//  ButtonVibration.swift
//  Trippi
//
//  Created by macmini50 on 03/08/23.
//

import UIKit

protocol HasButtonVibration {
    func likeVibration()
    func saveVibration()
}

extension HasButtonVibration where Self: UIViewController {
    func likeVibration() {
        UIImpactFeedbackGenerator(style: .medium).impactOccurred()
    }
    
    func saveVibration() {
        UIImpactFeedbackGenerator(style: .medium).impactOccurred()
    }
}

extension HasButtonVibration where Self: UICollectionViewCell {
    func likeVibration() {
        UIImpactFeedbackGenerator(style: .medium).impactOccurred()
    }
    
    func saveVibration() {
        UIImpactFeedbackGenerator(style: .medium).impactOccurred()
    }
}

extension HasButtonVibration where Self: UITableViewCell {
    func likeVibration() {
        UIImpactFeedbackGenerator(style: .medium).impactOccurred()
    }
    
    func saveVibration() {
        UIImpactFeedbackGenerator(style: .medium).impactOccurred()
    }
}
