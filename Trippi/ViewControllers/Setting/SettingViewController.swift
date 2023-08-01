//
//  SettingViewController.swift
//  Trippi
//
//  Created by Aman Raghuvanshi on 24/07/23.
//

import UIKit

class SettingViewController: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var badgeView: UIView!
    @IBOutlet weak var profileButton: UIButton!
    @IBOutlet weak var profileButtonContainerView: UIView!
    
    //setting view
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var crossButton: UIButton!
    
    @IBOutlet weak var tableViewTopConstraint: NSLayoutConstraint!
    
    //var's
    var settings = [
        SettingsModel(name: "edit profile", icon: "profile"),
        SettingsModel(name: "notifications", icon: "notification"),
        SettingsModel(name: "blocked users", icon: "blocked"),
        SettingsModel(name: "report a bug", icon: "bug"),
        SettingsModel(name: "privacy policy", icon: "privacy"),
        SettingsModel(name: "change password", icon: "password")
    ]
    
    var isVCLoded = false
    
    var cellHeight = 45
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: SettingTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: SettingTableViewCell.identifier)
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    //custom methods
    func setUpUI() {
        badgeView.alpha = 0
        profileButton.alpha = 0
        
        profileButton.layer.cornerRadius = 24
        badgeView.layer.cornerRadius = 10
    }
    
    //MARK: - Actions
    @IBAction func onClickCross(_ sender: Any) {
        self.dismiss(animated: true)
    }
}

extension SettingViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SettingTableViewCell.identifier) as! SettingTableViewCell
        cell.selectionStyle = .none
        cell.configure(setting: settings[indexPath.row])
        return cell
    }
}
