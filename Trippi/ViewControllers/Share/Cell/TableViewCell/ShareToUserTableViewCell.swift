//
//  ShareToUserTableViewCell.swift
//  Trippi
//
//  Created by Aman Raghuvanshi on 07/08/23.
//

import UIKit

class ShareToUserTableViewCell: UITableViewCell {

    //MARK: Outlets
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var selectedImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        userImageView.layer.cornerRadius = 10
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(shareUser: ShareUserModel) {
        userImageView.image = UIImage(named: shareUser.pic)
        usernameLabel.text = shareUser.username
        selectedImageView.image = shareUser.isSelected ? UIImage(systemName: "circle.fill") :  UIImage(systemName: "circle")
    }
    
}
