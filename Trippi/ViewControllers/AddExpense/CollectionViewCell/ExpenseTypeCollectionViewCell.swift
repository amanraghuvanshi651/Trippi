//
//  ExpenseTypeCollectionViewCell.swift
//  Trippi
//
//  Created by macmini50 on 23/08/23.
//

import UIKit

class ExpenseTypeCollectionViewCell: UICollectionViewCell {

    //MARK: - Outlets
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var expenseTypeImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        containerView.layer.cornerRadius = 25
    }
    
    func configure(expenseType: AddExpenseTypeModel) {
        expenseTypeImageView.image = UIImage(named: expenseType.expenseType.rawValue)
        containerView.backgroundColor = expenseType.isSelected  ? UIColor(named: BUTTON_BACKGROUND_COLOR) : .clear
    }
}
