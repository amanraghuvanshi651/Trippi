//
//  SettingTableViewCell.swift
//  Trippi
//
//  Created by macmini50 on 25/07/23.
//

import UIKit

class SettingTableViewCell: UITableViewCell {
    static let identifier = "SettingTableViewCell"

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var settingImageView: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(setting: SettingsModel) {
        titleLabel.text = setting.name
        settingImageView.image = UIImage(named: setting.icon)
    }
    
}
