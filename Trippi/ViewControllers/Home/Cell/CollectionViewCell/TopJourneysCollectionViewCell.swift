//
//  TopJourneysCollectionViewCell.swift
//  Trippi
//
//  Created by Aman Raghuvanshi on 28/07/23.
//

import UIKit

protocol TopJourneysCollectionViewCellDelegate: AnyObject {
    func onClickLike(indexPath: IndexPath)
    func onClickSave(indexPath: IndexPath)
}

class TopJourneysCollectionViewCell: UICollectionViewCell, HasButtonVibration {
    
    weak var delegate: TopJourneysCollectionViewCellDelegate?
    
    var indexPath = IndexPath()
    var topJourney: TopTripModel?
    
    //MARK: - Outlet's
    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var tripImageView: UIImageView!
    
    //buttons
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var chatButton: UIButton!
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    
    //labels
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        containerView.layer.cornerRadius = 20
        tripImageView.layer.cornerRadius = 20
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.likeButton.setImage(UIImage(named: "heardGray"), for: .normal)
        self.saveButton.setImage(UIImage(named: "saveGray"), for: .normal)
    }
    
    func configure(topJourney: TopTripModel) {
        self.topJourney = topJourney
        titleLabel.text = topJourney.title
        descriptionLabel.text = topJourney.description
        
        guard let imageURL = Bundle.main.url(forResource: topJourney.image, withExtension: "jpg") else {return}
        tripImageView.kf.setImage(with: imageURL)
        
        self.likeButton.setImage(topJourney.isLiked ? UIImage(named: "heartRed") : UIImage(named: "heartGray"), for: .normal)
        self.saveButton.setImage(topJourney.isSaved ? UIImage(named: "saveYellow") : UIImage(named: "saveGray"), for: .normal)
    }
    
    //MARK: - Action's
    @IBAction func onClickLikeButton(_ sender: Any) {
        delegate?.onClickLike(indexPath: indexPath)
        likeVibration()
        likeButton.bounceAnimation()
        topJourney?.isLiked.toggle()
        likeButton.setImage(topJourney?.isLiked ?? false ? UIImage(named: "heartRed") : UIImage(named: "heartGray"), for: .normal)
//        UIView.animate(withDuration: 0.5) { [weak self] in
//            guard let self = self else { return }
//            self.likeButton.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
//            UIView.animate(withDuration: 2.0,
//                           delay: 0,
//                           usingSpringWithDamping: 0.2,
//                           initialSpringVelocity: 6.0,
//                           options: .allowUserInteraction,
//                           animations: { [weak self] in
//                guard let self = self else { return }
//                self.likeButton.transform = .identity
//            },completion: nil)
//        }
    }
    
    @IBAction func onClickChatButton(_ sender: Any) {
    }
    
    @IBAction func onClickShareButton(_ sender: Any) {
    }
    
    @IBAction func onClickSaveButton(_ sender: Any) {
        saveVibration()
        delegate?.onClickSave(indexPath: indexPath)
        saveButton.bounceAnimation()
        topJourney?.isSaved.toggle()
        saveButton.setImage(topJourney?.isSaved ?? false ? UIImage(named: "saveYellow") : UIImage(named: "saveGray"), for: .normal)
        
//        UIView.animate(withDuration: 0.5) { [weak self] in
//            guard let self = self else { return }
//            self.saveButton.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
//            UIView.animate(withDuration: 2.0,
//                           delay: 0,
//                           usingSpringWithDamping: 0.2,
//                           initialSpringVelocity: 6.0,
//                           options: .allowUserInteraction,
//                           animations: { [weak self] in
//                guard let self = self else { return }
//                self.saveButton.transform = .identity
//            },completion: nil)
//        }
    }

}
