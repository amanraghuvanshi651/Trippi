//
//  CommentTableViewCell.swift
//  Trippi
//
//  Created by Aman Raghuvanshi on 08/08/23.
//

import UIKit

protocol CommentTableViewCellDelegate: AnyObject {
    func onClickLike(indexPath: IndexPath)
}

class CommentTableViewCell: UITableViewCell {
    
    weak var delegate: CommentTableViewCellDelegate?
    var indexPath = IndexPath()
    
    //MARK: - Outlets
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var likesLabel: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        userImageView.layer.cornerRadius = 15
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(comment: CommentDataModel, indexPath: IndexPath) {
        self.indexPath = indexPath
        userImageView.image = UIImage(named: comment.pic)
        usernameLabel.text = comment.username
        commentLabel.text = comment.comment
        likesLabel.text = "\(comment.likesCount) likes"
        likeButton.setImage(comment.isLiked ? UIImage(named: "heartRed") : UIImage(named: "heartGray"), for: .normal)
        
        likesLabel.isHidden = Int(comment.likesCount) == 0
    }
    
    //MARK: - Actions
    @IBAction func onClickReply(_ sender: Any) {
    }
    
    @IBAction func onClickLikeButton(_ sender: Any) {
        likeButton.setImage(UIImage(named: "heartRed"), for: .normal)
        delegate?.onClickLike(indexPath: indexPath)
    }
    
    @IBAction func onClickUserProfile(_ sender: Any) {
    }
}
