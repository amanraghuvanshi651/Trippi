//
//  TripDatesCollectionViewCell.swift
//  Trippi
//
//  Created by Aman Raghuvanshi on 17/08/23.
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
        containerView.layer.cornerRadius = 20
        containerView.clipsToBounds = true
        containerView.layer.masksToBounds = true
    }
    
    func configure(tripDate: TripDate) {
        containerView.backgroundColor = tripDate.isSelected ? .black : .white
        dateLabel.textColor = tripDate.isSelected ? .white : .black
        dateLabel.text = dateFormatter.string(from: tripDate.date)
    }
    
    func configureAddButton() {
        containerView.backgroundColor = UIColor(named: BUTTON_BACKGROUND_COLOR)
        dateLabel.textColor = .black
        dateLabel.text = "Add +"
    }
}
