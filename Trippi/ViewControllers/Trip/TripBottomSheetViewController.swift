//
//  TripBottomSheetViewController.swift
//  Trippi
//
//  Created by macmini50 on 21/08/23.
//

import UIKit

protocol TripBottomSheetViewControllerDelegate: AnyObject {
    func onClickCross()
}

class TripBottomSheetViewController: UIViewController {
    weak var delegate: TripBottomSheetViewControllerDelegate?
    
    var selectedOption: TripOptions = .daysPlan
    var tripData: TripDataModel? = TripDataModel(id: "dsadsa", title: "Trip to Bhusan", image: "", dates: [TripDate(date: Date(), isSelected: true), TripDate(date: Date(), isSelected: false), TripDate(date: Date(), isSelected: false), TripDate(date: Date(), isSelected: false), TripDate(date: Date(), isSelected: false)], dayPlan: [TripDayPlan()], reservations: [TripReservation(id: "", reservationType: .bus, fromPlace: "", toPlace: ""), TripReservation(id: "", reservationType: .flight, fromPlace: "", toPlace: ""), TripReservation(id: "", reservationType: .train, fromPlace: "", toPlace: "")], budget: TripBudget())
    
    //MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tripViewCrossButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        setUpTableView()
    }
    
    //MARK: - Actions
    @IBAction func onClickCrossButton(_ sender: Any) {
        self.dismiss(animated: true) {
            self.delegate?.onClickCross()
        }
    }
    
    //MARK: - Custom Methods
    func setUpUI() {
        tripViewCrossButton.layer.cornerRadius = 25
    }
    
    func setUpTableView() {
        tableView.separatorStyle = .none
        tableView.register(UINib(nibName: TripHeaderTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: TripHeaderTableViewCell.identifier)
        tableView.register(UINib(nibName: TripOptionsTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: TripOptionsTableViewCell.identifier)
        tableView.register(UINib(nibName: TripDatesTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: TripDatesTableViewCell.identifier)
        tableView.register(UINib(nibName: TripReservationTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: TripReservationTableViewCell.identifier)
    }
}

//MARK: - Table view Delegate and Datasource
extension TripBottomSheetViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 2
        } else {
            switch selectedOption {
            case .daysPlan:
                return (tripData?.dayPlan.count ?? 0) + 10
            case .reservations:
                return (tripData?.reservations.count ?? 0) + 1
            case .budget:
                return 10
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            switch indexPath.row {
            case 0:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: TripHeaderTableViewCell.identifier, for: indexPath) as? TripHeaderTableViewCell else {
                    return UITableViewCell()
                }
                cell.selectionStyle = .none
                return cell
            case 1:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: TripOptionsTableViewCell.identifier, for: indexPath) as? TripOptionsTableViewCell else {
                    return UITableViewCell()
                }
                cell.selectionStyle = .none
                cell.delegate = self
                return cell
            default:
                return UITableViewCell()
            }
        } else {
            switch selectedOption {
            case .daysPlan:
                switch indexPath.row {
                case 0:
                    guard let cell = tableView.dequeueReusableCell(withIdentifier: TripDatesTableViewCell.identifier, for: indexPath) as? TripDatesTableViewCell else {
                        return UITableViewCell()
                    }
                    cell.delegate = self
                    cell.selectionStyle = .none
                    return cell
                default:
                    return UITableViewCell()
                }
            case .reservations:
                switch indexPath.row {
                case tripData?.reservations.count:
                    return UITableViewCell()
                default:
                    guard let cell = tableView.dequeueReusableCell(withIdentifier: TripReservationTableViewCell.identifier, for: indexPath) as? TripReservationTableViewCell else {
                        return UITableViewCell()
                    }
                    cell.configure(tripReservation: tripData!.reservations[indexPath.row])
                    cell.selectionStyle = .none
                    return cell
                }
            case .budget:
                return UITableViewCell()
            }
        }
    }
}

//MARK: - Trip Options cell delegate
extension TripBottomSheetViewController: TripOptionsTableViewCellDelegate {
    func onClickOption(option: TripOptions) {
        if selectedOption != option {
            var animation = UITableView.RowAnimation.left
            switch option {
            case .budget:
                animation = .left
            case .daysPlan:
                animation = .right
            case .reservations:
                animation = selectedOption == .budget ? .right : .left
            }
            selectedOption = option
            DispatchQueue.main.async {
                self.tableView.reloadSections(IndexSet(integer: 1), with: animation)
            }
        }
    }
}

//MARK: - Trip Dates Cell Delegate
extension TripBottomSheetViewController: TripDatesTableViewCellDelegate {
    func onClickDate(tripDate: TripDate, indexPath: IndexPath) {
    }
    
    func onClickAddDate() {
    }
}
