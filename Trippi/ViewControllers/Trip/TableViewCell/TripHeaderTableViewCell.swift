//
//  TripHeaderTableViewCell.swift
//  Trippi
//
//  Created by Aman Raghuvanshi on 09/08/23.
//

import UIKit

class TripHeaderTableViewCell: UITableViewCell {

    
    var gradient = CAGradientLayer()
    
    //MARK: - Outlets
    @IBOutlet weak var tripImageView: UIImageView!
    @IBOutlet weak var tripTitleLabel: UILabel!
    @IBOutlet weak var topGradientView: UIView!
    
    //user image
    @IBOutlet weak var user1: UIImageView!
    @IBOutlet weak var user1ContainerView: UIView!
    @IBOutlet weak var user2: UIImageView!
    @IBOutlet weak var user2ContainerView: UIView!
    @IBOutlet weak var user3: UIImageView!
    @IBOutlet weak var user3ContainerView: UIView!
    @IBOutlet weak var user4: UIImageView!
    @IBOutlet weak var user4ContainerView: UIView!
    @IBOutlet weak var userStackView: UIStackView!
    
    @IBOutlet weak var blurView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        tripImageView.layer.cornerRadius = 30
        tripTitleLabel.textColor = tripImageView.image?.averageColor
        topGradientView.alpha = 0.8
        user1.layer.cornerRadius = 18
        user2.layer.cornerRadius = 18
        user3.layer.cornerRadius = 18
        user4.layer.cornerRadius = 18
        blurView.layer.cornerRadius = 18
        user1ContainerView.layer.cornerRadius = 20
        user2ContainerView.layer.cornerRadius = 20
        user3ContainerView.layer.cornerRadius = 20
        user4ContainerView.layer.cornerRadius = 20
        userStackView.bringSubviewToFront(user3ContainerView)
        userStackView.bringSubviewToFront(user2ContainerView)
        userStackView.bringSubviewToFront(user1ContainerView)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        addGradient()
    }
    
    //MARK: - Actions
    @IBAction func onClickMomentsButton(_ sender: Any) {
    }
    
    //MARK: - Custom Methods
    func addGradient() {
        gradient.removeFromSuperlayer()
        gradient.cornerRadius = 30
        gradient.frame = topGradientView.bounds
        gradient.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        gradient.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]

        topGradientView.layer.insertSublayer(gradient, at: 0)
    }
}
