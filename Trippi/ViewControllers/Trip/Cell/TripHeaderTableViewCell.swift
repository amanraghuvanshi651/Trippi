//
//  TripHeaderTableViewCell.swift
//  Trippi
//
//  Created by Aman Raghuvanshi on 09/08/23.
//

import UIKit

class TripHeaderTableViewCell: UITableViewCell {

    //MARK: - Outlets
    @IBOutlet weak var tripImageView: UIImageView!
    @IBOutlet weak var tripTitleLabel: UILabel!
    
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
    
    //MARK: - Actions
    @IBAction func onClickMomentsButton(_ sender: Any) {
    }
}
