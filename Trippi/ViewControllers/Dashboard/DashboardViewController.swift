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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.separatorStyle = .none
        tableView.register(UINib(nibName: OngoingTripTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: OngoingTripTableViewCell.identifier)
        tableView.register(UINib(nibName: PlannedTripTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: PlannedTripTableViewCell.identifier)
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
            return cell
        default:
            return UITableViewCell()
        }
    }
}
