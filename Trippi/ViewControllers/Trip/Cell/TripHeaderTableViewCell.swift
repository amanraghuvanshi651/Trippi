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
    @IBOutlet weak var user2: UIImageView!
    @IBOutlet weak var user3: UIImageView!
    @IBOutlet weak var user4: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        tripImageView.layer.cornerRadius = 30
        user1.layer.cornerRadius = 20
        user2.layer.cornerRadius = 20
        user3.layer.cornerRadius = 20
        user4.layer.cornerRadius = 20
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    //MARK: - Actions
    @IBAction func onClickMomentsButton(_ sender: Any) {
    }
}
