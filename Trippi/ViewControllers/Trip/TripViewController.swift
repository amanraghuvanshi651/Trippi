//
//  TripViewController.swift
//  Trippi
//
//  Created by Aman Raghuvanshi on 09/08/23.
//

import UIKit

class TripViewController: UIViewController {
    
    let defaultHeight: CGFloat = UIScreen.main.bounds.height - 80
    let dismissibleHeight: CGFloat = 150
    let maximumContainerHeight: CGFloat = UIScreen.main.bounds.height - 80
    let minimumContainerHeight:CGFloat = UIScreen.main.bounds.height / 2
    
    var panGesture = UIPanGestureRecognizer()
    var currentContainerHeight: CGFloat = UIScreen.main.bounds.height / 2
    var previousScrollOffset: CGFloat = 0
    var isKeyboardVisible = true
    var isDragedByUser = false
    var selectedOption: TripOptions = .daysPlan
    
    var tripData: TripDataModel? = TripDataModel(id: "dsadsa", title: "Trip to Bhusan", image: "", dates: [TripDate(date: Date(), isSelected: true), TripDate(date: Date(), isSelected: false), TripDate(date: Date(), isSelected: false), TripDate(date: Date(), isSelected: false), TripDate(date: Date(), isSelected: false)], dayPlan: [TripDayPlan()], reservations: [TripReservation(id: "", reservationType: .bus, fromPlace: "", toPlace: ""), TripReservation(id: "", reservationType: .flight, fromPlace: "", toPlace: ""), TripReservation(id: "", reservationType: .train, fromPlace: "", toPlace: "")], budget: TripBudget())

    //MARK: - Outlets
    //Trip View
    @IBOutlet weak var tripContainerView: UIView!
    @IBOutlet weak var topStackView: UIStackView!
    @IBOutlet weak var tripViewCrossButton: UIButton!
    
    @IBOutlet weak var tripTitleTopLabel: UILabel!
    @IBOutlet weak var topDragableView: UIView!
    @IBOutlet weak var topDraggableSubView: UIView!
    
    @IBOutlet weak var tableView: UITableView!
    
    //Map
    @IBOutlet weak var containerViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var stackViewTopConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpUI()
        setUpTableView()
        setupPanGesture()
    }
    
    //MARK: - Actions
    @IBAction func onClickCrossButton(_ sender: Any) {
        self.dismissOrPop()
    }
    
    
    //MARK: - Custom Methods
    func setUpUI() {
        containerViewHeightConstraint.constant = currentContainerHeight
        tripViewCrossButton.layer.cornerRadius = 25
        tripContainerView.layer.cornerRadius = 30
        topDraggableSubView.layer.cornerRadius = 2.5
    }
    
    func setUpTableView() {
        tableView.separatorStyle = .none
        tableView.register(UINib(nibName: TripHeaderTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: TripHeaderTableViewCell.identifier)
        tableView.register(UINib(nibName: TripOptionsTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: TripOptionsTableViewCell.identifier)
        tableView.register(UINib(nibName: TripDatesTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: TripDatesTableViewCell.identifier)
        tableView.register(UINib(nibName: TripReservationTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: TripReservationTableViewCell.identifier)
    }
    
    func setupPanGesture() {
        panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture))
        panGesture.delaysTouchesBegan = false
        panGesture.delaysTouchesEnded = false
        topDragableView.addGestureRecognizer(panGesture)
    }
    
    @objc func handlePanGesture(gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: view)
        let isDraggingDown = translation.y > 0
        let newHeight = currentContainerHeight - translation.y

        switch gesture.state {
        case .changed:
            if newHeight < maximumContainerHeight {
                containerViewHeightConstraint?.constant = newHeight
                view.layoutIfNeeded()
            }
        case .ended:
            if newHeight < minimumContainerHeight && isDraggingDown {
                animateMinimumHeight(dismissibleHeight)
            }
            else if newHeight < defaultHeight && isDraggingDown {
                animateContainerHeight(minimumContainerHeight)
            }
            else if newHeight < defaultHeight {
                animateContainerHeight(defaultHeight)
            }
        default:
            break
        }
    }
    
    func animateContainerHeight(_ height: CGFloat) {
        UIView.animate(withDuration: 0.4) {
            self.containerViewHeightConstraint?.constant = height
            self.stackViewTopConstraint.constant = 10
            
            self.tripTitleTopLabel.alpha = 0
            self.view.layoutIfNeeded()
        } completion: { _ in
            self.tripTitleTopLabel.isHidden = true
        }
        currentContainerHeight = height
    }
    
    func animateMinimumHeight(_ height: CGFloat) {
        self.tripTitleTopLabel.isHidden = false
        UIView.animate(withDuration: 0.4) {
            self.containerViewHeightConstraint?.constant = height
            self.stackViewTopConstraint.constant = 30
            
            self.tripTitleTopLabel.alpha = 1
            self.view.layoutIfNeeded()
        } completion: { _ in
        }
        currentContainerHeight = height
    }
}

//MARK: - Table view Delegate and Datasource
extension TripViewController: UITableViewDelegate, UITableViewDataSource {
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
                return tripData?.reservations.count ?? 0
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
                guard let cell = tableView.dequeueReusableCell(withIdentifier: TripReservationTableViewCell.identifier, for: indexPath) as? TripReservationTableViewCell else {
                    return UITableViewCell()
                }
                cell.configure(tripReservation: tripData!.reservations[indexPath.row])
                cell.selectionStyle = .none
                return cell
            case .budget:
                return UITableViewCell()
            }
        }
    }
}

//MARK: - Trip Options cell delegate
extension TripViewController: TripOptionsTableViewCellDelegate {
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
extension TripViewController: TripDatesTableViewCellDelegate {
    func onClickDate(tripDate: TripDate, indexPath: IndexPath) {
    }
    
    func onClickAddDate() {
    }
}
