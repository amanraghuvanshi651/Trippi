//
//  CustomHeaderView.swift
//  Trippi
//
//  Created by Aman Raghuvanshi on 21/07/23.
//

import UIKit

class CustomHeaderView: UITableViewHeaderFooterView {
    static let identifier = "CustomHeaderView"

    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var profileButton: UIButton!
    @IBOutlet weak var badgeView: UIView!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var searchContainerView: UIView!
    
    override func layoutSubviews() {
        print("jhingalala")
        profileButton.layer.cornerRadius = 20
        searchContainerView.layer.cornerRadius = 20
        badgeView.layer.cornerRadius = 5
    }
}
