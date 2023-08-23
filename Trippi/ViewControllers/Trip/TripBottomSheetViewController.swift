//
//  TripBottomSheetViewController.swift
//  Trippi
//
//  Created by Aman Raghuvanshi on 21/08/23.
//

import UIKit

protocol TripBottomSheetViewControllerDelegate: AnyObject {
    func onClickCross()
}

class TripBottomSheetViewController: UIViewController {
    weak var delegate: TripBottomSheetViewControllerDelegate?
    var sheetDetent: BottomSheetDetent = .medium
    
    private var selectedOption: TripOptions = .daysPlan
    private var tripData: TripDataModel? = TripDataModel(
        id: "dsadsa",
        title: "Trip to Bhusan",
        image: "",
        dates: [
            TripDate(date: Date(), isSelected: true),
            TripDate(date: Date(), isSelected: false),
            TripDate(date: Date(), isSelected: false),
            TripDate(date: Date(), isSelected: false),
            TripDate(date: Date(), isSelected: false)
        ],
        dayPlan: [TripDayPlan()],
        reservations: [],
        budget: TripBudget(
            id: "",
            total: 8000,
            expenses: [
                TripExpense(id: "", name: "Dinner", amount: 600, expenseType: .food, pic: TripExpenseType.food.rawValue),
                TripExpense(id: "", name: "Fuel Up", amount: 200, expenseType: .fuel, pic: TripExpenseType.fuel.rawValue),
                TripExpense(id: "", name: "Movie Tickets", amount: 900, expenseType: .ticket, pic: TripExpenseType.ticket.rawValue),
                TripExpense(id: "", name: "Taxi", amount: 412, expenseType: .transport, pic: TripExpenseType.transport.rawValue),
                TripExpense(id: "", name: "Lunch", amount: 125, expenseType: .food, pic: TripExpenseType.food.rawValue),
                TripExpense(id: "", name: "Park View", amount: 155, expenseType: .custom, pic: TripExpenseType.custom.rawValue),
                TripExpense(id: "", name: "Amusment Park", amount: 1500, expenseType: .activity, pic: TripExpenseType.activity.rawValue),
                TripExpense(id: "", name: "Fuel Up", amount: 300, expenseType: .fuel, pic: TripExpenseType.fuel.rawValue),
                TripExpense(id: "", name: "Taxi", amount: 50, expenseType: .transport, pic: TripExpenseType.transport.rawValue)
            ]
        )
    )
//    TripReservation(id: "", reservationType: .bus, fromPlace: "", toPlace: "", date: Date()), TripReservation(id: "", reservationType: .flight, fromPlace: "", toPlace: "", date: Date()), TripReservation(id: "", reservationType: .train, fromPlace: "", toPlace: "", date: Date())
    
    //MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tripViewCrossButton: UIButton!
    @IBOutlet weak var addButton: UIButton!
    
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
    
    @IBAction func onClickAddButton(_ sender: Any) {
        switch selectedOption {
        case .daysPlan:
            break
        case .reservations:
            guard let vc = getVC(storyboard: .addReservation, vc: AddReservationViewController.identifier) as? AddReservationViewController else {
                return
            }
            self.presentVC(vc: vc)
        case .budget:
            guard let vc = getVC(storyboard: .addExpense, vc: AddExpenseViewController.identifier) as? AddExpenseViewController else {
                return
            }
            self.presentVC(vc: vc)
        }
    }
    
    //MARK: - Custom Methods
    private func setUpUI() {
        tripViewCrossButton.layer.cornerRadius = 25
        addButton.layer.cornerRadius = 10
    }
    
    private func setUpTableView() {
        tableView.separatorStyle = .none
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 80, right: 0)
        tableView.register(UINib(nibName: TripHeaderTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: TripHeaderTableViewCell.identifier)
        tableView.register(UINib(nibName: TripOptionsTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: TripOptionsTableViewCell.identifier)
        tableView.register(UINib(nibName: TripDatesTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: TripDatesTableViewCell.identifier)
        tableView.register(UINib(nibName: TripReservationTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: TripReservationTableViewCell.identifier)
        tableView.register(UINib(nibName: AddNewTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: AddNewTableViewCell.identifier)
        tableView.register(UINib(nibName: TripBudgetTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: TripBudgetTableViewCell.identifier)
        tableView.register(UINib(nibName: TripExpenseTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: TripExpenseTableViewCell.identifier)
    }
    
    func setUpSheetDetent(detent: BottomSheetDetent) {
        sheetDetent = detent
        
        switch sheetDetent {
        case .medium:
            hideAddButton()
        case .large:
            showAddButton()
        case .custom:
            hideAddButton()
        }
    }
    
    func setUpAddButton(option: TripOptions) {
        if selectedOption != option {
            UIView.animate(withDuration: 0.2) {
                switch option {
                case .budget:
                    self.addButton.setTitle(" Expense", for: .normal)
                case .daysPlan:
                    self.addButton.setTitle(" Place", for: .normal)
                case .reservations:
                    self.addButton.setTitle(" Reservation", for: .normal)
                }
            }
        }
    }
    
    private func hideAddButton() {
        UIView.animate(withDuration: 0.2) {
            self.addButton.alpha = 0
        } completion: { _ in
            self.addButton.isHidden = true
        }
    }
    
    private func showAddButton() {
        addButton.isHidden = false
        UIView.animate(withDuration: 0.3) {
            self.addButton.alpha = 1
        }
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
                return (tripData?.dayPlan.count ?? 0) + 1
            case .reservations:
                return (tripData?.reservations.count ?? 0)
            case .budget:
                return (tripData?.budget.expenses.count ?? 0) + 1
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
                guard let cell = tableView.dequeueReusableCell(withIdentifier: TripReservationTableViewCell.identifier, for: indexPath) as? TripReservationTableViewCell else {
                    return UITableViewCell()
                }
                cell.configure(tripReservation: tripData?.reservations[indexPath.row] ?? TripReservation(id: "", reservationType: .bus, fromPlace: "", toPlace: "", date: Date()))
                cell.selectionStyle = .none
                return cell
            case .budget:
                switch indexPath.row {
                case 0 :
                    guard let cell = tableView.dequeueReusableCell(withIdentifier: TripBudgetTableViewCell.identifier, for: indexPath) as? TripBudgetTableViewCell else {
                        return UITableViewCell()
                    }
                    cell.configure(budget: tripData!.budget)
                    cell.selectionStyle = .none
                    return cell
                default:
                    guard let cell = tableView.dequeueReusableCell(withIdentifier: TripExpenseTableViewCell.identifier, for: indexPath) as? TripExpenseTableViewCell else {
                        return UITableViewCell()
                    }
                    cell.configure(expense: tripData?.budget.expenses[indexPath.row - 1] ?? TripExpense(id: "", name: "", amount: 0.0, expenseType: .custom, pic: ""))
                    cell.selectionStyle = .none
                    return cell
                }
            }
        }
    }
}

//MARK: - Trip Options cell delegate
extension TripBottomSheetViewController: TripOptionsTableViewCellDelegate {
    func onClickOption(option: TripOptions) {
        if selectedOption != option {
            setUpAddButton(option: option)
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

//MARK: - Add New Cell Delegate
extension TripBottomSheetViewController: AddNewTableViewCellDelegate {
    func onClickAddButton() {
        let vc = getVC(storyboard: .addReservation, vc: AddReservationViewController.identifier) as! AddReservationViewController
        self.presentVC(vc: vc)
    }
}
