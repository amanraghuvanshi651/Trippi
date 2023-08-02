//
//  MomentTableViewCell.swift
//  Trippi
//
//  Created by macmini50 on 01/08/23.
//

import UIKit
import Lottie
import Kingfisher

class MomentTableViewCell: UITableViewCell {
    
    //MARK: - Outlets
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var followButton: UIButton!
    
    @IBOutlet weak var momentImageView: UIImageView!
    @IBOutlet weak var postDescriptionLabel: UILabel!
    
    @IBOutlet weak var doubleTapButton: UIButton!
    @IBOutlet weak var likeAnimationView: LottieAnimationView!
    
    @IBOutlet weak var momentImageViewHeightConstraint: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        followButton.layer.cornerRadius = 10
        userImageView.layer.cornerRadius = 10
        
        let doubleTap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleDoubleTap))
        doubleTap.numberOfTapsRequired = 2
        doubleTapButton.addGestureRecognizer(doubleTap)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
        
    func configure(moment: MomentModel, imageHeight: Double) {
        self.userImageView.image = UIImage(named: moment.userPic)
        self.usernameLabel.text = moment.username
        self.postDescriptionLabel.text = moment.description
        self.momentImageViewHeightConstraint.constant = CGFloat(imageHeight)
        guard let imageURL = Bundle.main.url(forResource: moment.image, withExtension: "jpg") else {return}
        momentImageView.kf.setImage(with: imageURL)
    }
    
    @objc func handleDoubleTap(sender: AnyObject?) {
        likeAnimationView.isHidden = false
        likeAnimationView.alpha = 1
        likeAnimationView.animationSpeed = 1.2
        likeAnimationView.loopMode = .playOnce
        likeAnimationView.backgroundColor = .clear
        likeAnimationView.play() { _ in
            UIView.animate(withDuration: 0.3) {
                self.likeAnimationView.alpha = 0
            } completion: { _ in
                self.likeAnimationView.isHidden = true
            }
        }
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