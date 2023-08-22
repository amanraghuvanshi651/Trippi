//
//  TirpExpenseTableViewCell.swift
//  Trippi
//
//  Created by Aman Raghuvanshi on 22/08/23.
//

import UIKit

class TripExpenseTableViewCell: UITableViewCell {

    @IBOutlet weak var expenseTypeImage: UIImageView!
    @IBOutlet weak var expenseLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure() {
        expenseLabel.text = "Petrol"
        amountLabel.text = "₹800.0"
    }
}
