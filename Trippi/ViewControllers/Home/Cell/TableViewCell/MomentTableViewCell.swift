//
//  MomentTableViewCell.swift
//  Trippi
//
//  Created by Aman Raghuvanshi on 01/08/23.
//

import UIKit
import Lottie
import Kingfisher

protocol MomentTableViewCellDelegate: AnyObject {
    func onClickFollow()
    func onClickMomentLike()
    func onClickMomentSave()
    func onClickMomentShare(indexPath: IndexPath)
    func onClickMomentComments()
}

class MomentTableViewCell: UITableViewCell, HasButtonVibration {
    var moment: MomentModel?
    weak var delegate: MomentTableViewCellDelegate?
    
    var indexPath = IndexPath()
    
    //MARK: - Outlets
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var followButton: UIButton!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var commentButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var shareButton: UIButton!
    
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
        
    func configure(moment: MomentModel, imageHeight: Double, indexPath: IndexPath) {
        self.indexPath = indexPath
        self.moment = moment
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
        likeButtonClicked(isSingleTap: false)
    }
    
    func likeButtonClicked(isSingleTap: Bool) {
        mediumVibration()
        likeButton.bounceAnimation(bounceScale: 0.8)
        moment?.isLiked.toggle()
        if isSingleTap {
            likeButton.setImage(moment?.isLiked ?? false ? UIImage(named: "heartRed") : UIImage(named: "heartGray"), for: .normal)
        } else {
            likeButton.setImage(UIImage(named: "heartRed"), for: .normal)
        }
        delegate?.onClickMomentLike()
    }
    
    //MARK: - Actions
    @IBAction func onClickFollowButton(_ sender: Any) {
        heavyVibration()
        followButton.bounceAnimation(bounceScale: 0.95)
        delegate?.onClickFollow()
    }
    
    @IBAction func onClickOptionButton(_ sender: Any) {
        
    }
    
    @IBAction func onClickLikeButton(_ sender: Any) {
        likeButtonClicked(isSingleTap: true)
    }
    
    @IBAction func onClickCommentButton(_ sender: Any) {
        mediumVibration()
        commentButton.bounceAnimation(bounceScale: 0.8)
        delegate?.onClickMomentComments()
    }
    
    @IBAction func onClickShareButton(_ sender: Any) {
        print(shareButton.frame)
        mediumVibration()
        delegate?.onClickMomentShare(indexPath: indexPath)
    }
    
    @IBAction func onClickSaveButton(_ sender: Any) {
        mediumVibration()
        saveButton.bounceAnimation(bounceScale: 0.8)
        moment?.isSaved.toggle()
        saveButton.setImage(moment?.isSaved ?? false ? UIImage(named: "saveYellow") : UIImage(named: "saveGray"), for: .normal)
        delegate?.onClickMomentSave()
    }
}
