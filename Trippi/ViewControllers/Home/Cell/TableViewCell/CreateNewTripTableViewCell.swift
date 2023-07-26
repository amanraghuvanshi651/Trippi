//
//  CreateNewTripTableViewCell.swift
//  Trippi
//
//  Created by macmini50 on 26/07/23.
//

import UIKit

protocol CreateNewTripTableViewCellDelegate: AnyObject {
    func onClickCreateTripButton()
}

class CreateNewTripTableViewCell: UITableViewCell {
    static let identifier = "CreateNewTripTableViewCell"

    weak var delegate: CreateNewTripTableViewCellDelegate?
    
    @IBOutlet weak var createTripButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        createTripButton.layer.cornerRadius = 20
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func onClickCreateTrip(_ sender: Any) {
        delegate?.onClickCreateTripButton()
    }
}
