//
//  HomeHeaderTableViewCell.swift
//  Trippi
//
//  Created by Abhay Singh Raghuvanshi on 22/07/23.
//

import UIKit

protocol HomeHeaderTableViewCellDelegate: AnyObject {
    func onClickProfileButton()
}

class HomeHeaderTableViewCell: UITableViewCell {
    static let identifier = "HomeHeaderTableViewCell"
    
    weak var delegate: HomeHeaderTableViewCellDelegate?
    
    //MARK: - Outlets
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var profileButton: UIButton!
    @IBOutlet weak var badgeView: UIView!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var searchContainerView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        profileButton.layer.cornerRadius = 20
        searchContainerView.layer.cornerRadius = 20
        badgeView.layer.cornerRadius = 5
    }
    
    //MARK: - Actions
    @IBAction func onClickProfileButton(_ sender: Any) {
        delegate?.onClickProfileButton()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
