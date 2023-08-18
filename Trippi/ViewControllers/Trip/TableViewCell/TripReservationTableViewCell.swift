//
//  TripReservationTableViewCell.swift
//  Trippi
//
//  Created by Abhay Singh Raghuvanshi on 19/08/23.
//

import UIKit

class TripReservationTableViewCell: UITableViewCell {
    
    //MARK: - Outlets
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var cutViewFirst: UIView!
    @IBOutlet weak var cutViewSecond: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        cutViewFirst.layer.cornerRadius = 2.5
        cutViewSecond.layer.cornerRadius = 2.5
        containerView.layer.cornerRadius = 10
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
