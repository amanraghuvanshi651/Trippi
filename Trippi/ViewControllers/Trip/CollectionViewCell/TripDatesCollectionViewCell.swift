//
//  TripDatesCollectionViewCell.swift
//  Trippi
//
//  Created by macmini50 on 17/08/23.
//

import UIKit

class TripDatesCollectionViewCell: UICollectionViewCell {
    
    let dateFormatter = DateFormatter()

    //MARK: - Outlets
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        dateFormatter.dateFormat = "MMMM d"
    }
    
    func configure(date: Date) {
        containerView.backgroundColor = .brown
        containerView.layer.cornerRadius = 20
        containerView.clipsToBounds = true
        containerView.layer.masksToBounds = true
        dateLabel.text = dateFormatter.string(from: date)
    }
}
