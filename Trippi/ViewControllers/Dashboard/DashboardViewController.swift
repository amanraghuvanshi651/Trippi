//
//  DashboardViewController.swift
//  Trippi
//
//  Created by Aman Raghuvanshi on 04/08/23.
//

import UIKit

class DashboardViewController: UIViewController {

    //MARK: - Outlet's
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var noTripView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        noTripView.isHidden = true
        tableView.separatorStyle = .none
        tableView.register(UINib(nibName: OngoingTripTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: OngoingTripTableViewCell.identifier)
        tableView.register(UINib(nibName: PlannedTripTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: PlannedTripTableViewCell.identifier)
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 120, right: 0)
    }
}

//MARK: - Table View Delegate and DataSource
extension DashboardViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: OngoingTripTableViewCell.identifier) as! OngoingTripTableViewCell
            cell.selectionStyle = .none
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: PlannedTripTableViewCell.identifier) as! PlannedTripTableViewCell
            cell.selectionStyle = .none
            
            cell.frame = tableView.bounds
            cell.layoutIfNeeded()
            cell.collectionViewHeightConstraint.constant = (((cell.collectionView.frame.width / 2) + 20) * 2) + 10
            cell.collectionView.reloadData()
            return cell
        default:
            return UITableViewCell()
        }
    }
}
