//
//  TrippiTabBarItemCollectionViewCell.swift
//  Trippi
//
//  Created by macmini50 on 04/08/23.
//

import UIKit

class TrippiTabBarItemCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var itemTitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        containerView.layer.cornerRadius = 20
    }
    
    func configure(item: TrippiTabBarItem, isSelected: Bool) {
        itemImageView.image = UIImage(named: item.image)
        itemTitleLabel.text = item.title
        self.containerView.backgroundColor = isSelected ? UIColor(named: BUTTON_BACKGROUND_COLOR) : .clear
        updateUI(isSelected: isSelected)
    }
    
    func updateUI(isSelected: Bool) {
//        self.containerView.backgroundColor = isSelected ? UIColor(named: BUTTON_BACKGROUND_COLOR) : .clear
        self.itemTitleLabel.isHidden = !isSelected
        self.itemImageView.isHidden = isSelected
    }

}
