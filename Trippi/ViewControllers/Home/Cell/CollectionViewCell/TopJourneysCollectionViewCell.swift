//
//  TopJourneysCollectionViewCell.swift
//  Trippi
//
//  Created by Aman Raghuvanshi on 28/07/23.
//

import UIKit

class TopJourneysCollectionViewCell: UICollectionViewCell {
    
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
    
    //MARK: - Action's
    @IBAction func onClickLikeButton(_ sender: Any) {
    }
    
    @IBAction func onClickChatButton(_ sender: Any) {
    }
    
    @IBAction func onClickShareButton(_ sender: Any) {
    }
    
    @IBAction func onClickSaveButton(_ sender: Any) {
    }

}
