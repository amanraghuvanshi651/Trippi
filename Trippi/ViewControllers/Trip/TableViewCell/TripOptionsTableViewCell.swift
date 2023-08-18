//
//  TripOptionsTableViewCell.swift
//  Trippi
//
//  Created by Aman Raghuvanshi on 17/08/23.
//

import UIKit

protocol TripOptionsTableViewCellDelegate: AnyObject {
    func onClickOption(option: TripOptions)
}

class TripOptionsTableViewCell: UITableViewCell {

    weak var delegate: TripOptionsTableViewCellDelegate?
    
    //MARK: - Outlets
    @IBOutlet weak var daysPlanButton: UIButton!
    @IBOutlet weak var reservationsButton: UIButton!
    @IBOutlet weak var bidgetButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    //MARK: - Actions
    @IBAction func onClickDaysPlan(_ sender: Any) {
        UIView.animate(withDuration: 0.3) {
            self.daysPlanButton.setTitleColor(UIColor(named: TEXT_COLOR), for: .normal)
            self.reservationsButton.setTitleColor(UIColor(named: SECONDARY_TEXT_COLOR), for: .normal)
            self.bidgetButton.setTitleColor(UIColor(named: SECONDARY_TEXT_COLOR), for: .normal)
        }
        delegate?.onClickOption(option: .daysPlan)
    }
    @IBAction func onClickReservations(_ sender: Any) {
        UIView.animate(withDuration: 0.3) {
            self.daysPlanButton.setTitleColor(UIColor(named: SECONDARY_TEXT_COLOR), for: .normal)
            self.reservationsButton.setTitleColor(UIColor(named: TEXT_COLOR), for: .normal)
            self.bidgetButton.setTitleColor(UIColor(named: SECONDARY_TEXT_COLOR), for: .normal)
        }
        delegate?.onClickOption(option: .reservations)
    }
    @IBAction func onClickBudget(_ sender: Any) {
        UIView.animate(withDuration: 0.3) {
            self.daysPlanButton.setTitleColor(UIColor(named: SECONDARY_TEXT_COLOR), for: .normal)
            self.reservationsButton.setTitleColor(UIColor(named: SECONDARY_TEXT_COLOR), for: .normal)
            self.bidgetButton.setTitleColor(UIColor(named: TEXT_COLOR), for: .normal)
        }
        delegate?.onClickOption(option: .budget)
    }
}
