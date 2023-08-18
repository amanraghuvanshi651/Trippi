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
    
    var currentContainerHeight: CGFloat = UIScreen.main.bounds.height / 2
    var previousScrollOffset: CGFloat = 0
    var isKeyboardVisible = true
    var isDragedByUser = false
    var selectedOption: TripOptions = .daysPlan

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
        
        setupPanGesture()
        containerViewHeightConstraint.constant = currentContainerHeight
        tripViewCrossButton.layer.cornerRadius = 25
        tripContainerView.layer.cornerRadius = 30
        topDraggableSubView.layer.cornerRadius = 2.5
        
        tableView.separatorStyle = .none
        tableView.register(UINib(nibName: TripHeaderTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: TripHeaderTableViewCell.identifier)
        tableView.register(UINib(nibName: TripOptionsTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: TripOptionsTableViewCell.identifier)
        tableView.register(UINib(nibName: TripDatesTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: TripDatesTableViewCell.identifier)
    }
    
    //MARK: - Actions
    @IBAction func onClickCrossButton(_ sender: Any) {
        self.dismissOrPop()
    }
    
    var panGesture = UIPanGestureRecognizer()
    
    //MARK: - Custom Methods
    func setupPanGesture() {
        panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture))
        panGesture.delaysTouchesBegan = false
        panGesture.delaysTouchesEnded = false
//        topStackView.addGestureRecognizer(panGesture)
//        tableView.addGestureRecognizer(panGesture)
        topDragableView.addGestureRecognizer(panGesture)
//        panGesture.isEnabled = false
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
//                panGesture.isEnabled = true
                animateMinimumHeight(dismissibleHeight)
            }
            else if newHeight < defaultHeight && isDraggingDown {
//                panGesture.isEnabled = true
                animateContainerHeight(minimumContainerHeight)
            }
            else if newHeight < defaultHeight {
//                panGesture.isEnabled = false
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
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: TripHeaderTableViewCell.identifier, for: indexPath) as! TripHeaderTableViewCell
            cell.selectionStyle = .none
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: TripOptionsTableViewCell.identifier, for: indexPath) as! TripOptionsTableViewCell
            cell.selectionStyle = .none
            cell.delegate = self
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: TripDatesTableViewCell.identifier, for: indexPath) as! TripDatesTableViewCell
            cell.selectionStyle = .none
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        isDragedByUser = true
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        if scrollView.contentOffset.y <= 0 {
////            panGesture.isEnabled = true
//            if currentContainerHeight == defaultHeight {
//                isDragedByUser = false
//                animateContainerHeight(minimumContainerHeight)
//            } else if currentContainerHeight == minimumContainerHeight && isDragedByUser{
//                animateMinimumHeight(dismissibleHeight)
//            }
//        } else {
//            animateContainerHeight(maximumContainerHeight)
//        }
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        isDragedByUser = false
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        isDragedByUser = false
    }
}

//MARK: - Trip Options cell delegate
extension TripViewController: TripOptionsTableViewCellDelegate {
    func onClickOption(option: TripOptions) {
        selectedOption = option
    }
}
