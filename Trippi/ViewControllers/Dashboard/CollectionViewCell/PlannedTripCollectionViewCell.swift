//
//  PlannedTripCollectionViewCell.swift
//  Trippi
//
//  Created by macmini50 on 11/08/23.
//

import UIKit

class PlannedTripCollectionViewCell: UICollectionViewCell {

    //MARK: - Outlets
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var tripImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        containerView.layer.cornerRadius = 20
        tripImageView.layer.cornerRadius = 20
    }

}
