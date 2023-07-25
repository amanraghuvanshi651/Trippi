//
//  SettingViewController.swift
//  Trippi
//
//  Created by macmini50 on 24/07/23.
//

import UIKit

class SettingViewController: UIViewController {
    static let identifier = "SettingViewController"
    
    //MARK: - Outlets
    @IBOutlet weak var badgeView: UIView!
    @IBOutlet weak var profileButton: UIButton!
    
    //setting view
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var settingContainerView: UIView!
    @IBOutlet weak var crossButton: UIButton!
    
    //var's
    var buttonFrame = CGRect()
    var badgeFrame = CGRect()
    
    var settingViewHeight: CGFloat = 0.0
    var settingViewWidth: CGFloat = 0.0
    
    var isVCLoded = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: SettingTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: SettingTableViewCell.identifier)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setUpUIAfterLayout()
    }
    
    //custom methods
    func setUpUI() {
        profileButton.layer.cornerRadius = 15
        badgeView.layer.cornerRadius = 4
        settingContainerView.layer.cornerRadius = 20
        
        self.view.layoutIfNeeded()
    }
    
    func setUpUIAfterLayout() {
        profileButton.frame = buttonFrame
        badgeView.frame = badgeFrame
        
        let screenHeight = view.window?.screen.bounds.height ?? 0.0
        let screenWidth = view.window?.screen.bounds.width ?? 0.0
        self.settingContainerView.frame = CGRect(x: Int(screenWidth - 10), y: Int(buttonFrame.minY) - 10, width: 0, height: 0)
        let settingViewFrame = CGRect(x: 50, y: buttonFrame.minY - 10, width: screenWidth == 0.0 ? 0.0 : screenWidth - 60, height: screenHeight == 0.0 ? 0.0 : screenHeight - 150)
        self.crossButton.isHidden = false
        self.crossButton.alpha = 0
        
        UIView.transition(with: settingContainerView, duration: 0.2, options: [.curveEaseIn]) {
            self.settingContainerView.frame = settingViewFrame
        } completion: { _ in
            UIView.animate(withDuration: 0.3) {
                self.crossButton.alpha = 1
//                self.tableView.reloadData()
            }
        }
    }
    
    //MARK: - Actions
    @IBAction func onClickCross(_ sender: Any) {
        self.dismiss(animated: true)
    }
}

//MARK: - table view delegate and datasource
extension SettingViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SettingTableViewCell.identifier, for: indexPath) as! SettingTableViewCell
        cell.titleLabel.text = "setting"
        return cell
    }
    

}
