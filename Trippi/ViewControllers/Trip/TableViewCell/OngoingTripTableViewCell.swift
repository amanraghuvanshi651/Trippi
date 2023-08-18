//
//  OngoingTripTableViewCell.swift
//  Trippi
//
//  Created by Aman Raghuvanshi on 11/08/23.
//

import UIKit

class OngoingTripTableViewCell: UITableViewCell {

    @IBOutlet weak var containerview: UIView!
    @IBOutlet weak var tripImageView: UIImageView!
    @IBOutlet weak var tripTitleLabel: UILabel!
    @IBOutlet weak var daysLabel: UILabel!
    @IBOutlet weak var countryTitle: UILabel!
    @IBOutlet weak var dotView: UIView!
    
    //user images
    @IBOutlet weak var userStackView: UIStackView!
    @IBOutlet weak var userCountLabel: UILabel!
    
    @IBOutlet weak var user1BlurView: UIView!
    
    @IBOutlet weak var user1ImageView: UIImageView!
    @IBOutlet weak var user2ImageView: UIImageView!
    @IBOutlet weak var user3ImageView: UIImageView!
    @IBOutlet weak var user4ImageView: UIImageView!
    @IBOutlet weak var user1ContainerView: UIView!
    @IBOutlet weak var user2ContainerView: UIView!
    @IBOutlet weak var user3ContainerView: UIView!
    @IBOutlet weak var user4ContainerView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        //setting corner
        dotView.layer.cornerRadius = 2.5
        containerview.layer.cornerRadius = 20
        tripImageView.layer.cornerRadius = 20
        user1BlurView.layer.cornerRadius = 18
        user1ImageView.layer.cornerRadius = 18
        user2ImageView.layer.cornerRadius = 18
        user3ImageView.layer.cornerRadius = 18
        user4ImageView.layer.cornerRadius = 18
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
}
