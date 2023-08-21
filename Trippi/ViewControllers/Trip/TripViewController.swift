//
//  TripViewController.swift
//  Trippi
//
//  Created by Aman Raghuvanshi on 09/08/23.
//

import UIKit
import MapKit

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
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        presentBottomSheet()
    }
    
    //MARK: - Custom Methods
    func setUpUI() {
    }
    
    func presentBottomSheet() {
        guard let vc = getVC(storyboard: .trip, vc: TripBottomSheetViewController.identifier) as? TripBottomSheetViewController else {
            return
        }
        vc.delegate = self
        vc.isModalInPresentation = true
        if let sheet = vc.sheetPresentationController {
            sheet.detents = [.medium(), .large(), .custom(resolver: { context in
                0.25 * context.maximumDetentValue
            })]
            sheet.prefersGrabberVisible = true
            sheet.preferredCornerRadius = 25
            sheet.largestUndimmedDetentIdentifier = .medium
        }
        self.presentVC(vc: vc)
    }
}

//MARK: - Trip Bottom Sheet Delegate
extension TripViewController: TripBottomSheetViewControllerDelegate {
    func onClickCross() {
        self.dismissOrPop()
    }
}
