//
//  MomentTableViewCell.swift
//  Trippi
//
//  Created by macmini50 on 01/08/23.
//

import UIKit
import Lottie

class MomentTableViewCell: UITableViewCell {
    
    //MARK: - Outlets
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var followButton: UIButton!
    
    @IBOutlet weak var momentImageView: UIImageView!
    @IBOutlet weak var postDescriptionLabel: UILabel!
    
    @IBOutlet weak var likeAnimationView: LottieAnimationView!
    
    @IBOutlet weak var momentImageViewHeightConstraint: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        followButton.layer.cornerRadius = 10
        userImageView.layer.cornerRadius = 10
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(imageHeight: Double) {
        momentImageViewHeightConstraint.constant = CGFloat(imageHeight)
    }
    
    //MARK: - Actions
    @IBAction func onClickFollowButton(_ sender: Any) {
    }
    
    @IBAction func onClickOptionButton(_ sender: Any) {
    }
    
    
    @IBAction func onClickLikeButton(_ sender: Any) {
    }
    
    @IBAction func onClickCommentButton(_ sender: Any) {
    }
    
    @IBAction func onClickShareButton(_ sender: Any) {
    }
    
    @IBAction func onClickSaveButton(_ sender: Any) {
    }
}
