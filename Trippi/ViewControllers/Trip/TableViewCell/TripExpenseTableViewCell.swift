//
//  TirpExpenseTableViewCell.swift
//  Trippi
//
//  Created by Aman Raghuvanshi on 22/08/23.
//

import UIKit

class TripExpenseTableViewCell: UITableViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var expenseTypeImage: UIImageView!
    @IBOutlet weak var expenseLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        containerView.layer.cornerRadius = 10
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(expense: TripExpense) {
        expenseLabel.text = expense.name
        amountLabel.text = "₹\(expense.amount)"
        expenseTypeImage.image = UIImage(named: expense.pic)
    }
}
