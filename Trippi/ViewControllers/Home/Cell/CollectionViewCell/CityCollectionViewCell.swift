//
//  CityCollectionViewCell.swift
//  Trippi
//
//  Created by Aman Raghuvanshi on 21/07/23.
//

import UIKit

class CityCollectionViewCell: UICollectionViewCell {
    static let identifier = "CityCollectionViewCell"

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var cityImageView: UIImageView!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    
    @IBOutlet weak var cityImageViewHeightConstraint: NSLayoutConstraint!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        containerView.layer.cornerRadius = 20
        cityImageView.layer.cornerRadius = 20
    }

}
