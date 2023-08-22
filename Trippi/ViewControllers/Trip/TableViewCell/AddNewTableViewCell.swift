//
//  AddNewTableViewCell.swift
//  Trippi
//
//  Created by Aman Raghuvanshi on 21/08/23.
//

import UIKit
protocol AddNewTableViewCellDelegate: AnyObject {
    func onClickAddButton()
}

class AddNewTableViewCell: UITableViewCell {
    weak var delegate: AddNewTableViewCellDelegate?
    
    //MARK: - Outlets
    @IBOutlet weak var nextButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        nextButton.layer.cornerRadius = 20
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    //MARK: - Actions
    @IBAction func onClickNextButton(_ sender: Any) {
        delegate?.onClickAddButton()
    }
}
