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
    
    var bottomSheet: TripBottomSheetViewController = {
        guard let vc = getVC(storyboard: .trip, vc: TripBottomSheetViewController.identifier) as? TripBottomSheetViewController else {
            return TripBottomSheetViewController()
        }
        return vc
    }()

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
//        guard let vc = getVC(storyboard: .trip, vc: TripBottomSheetViewController.identifier) as? TripBottomSheetViewController else {
//            return
//        }
        bottomSheet.delegate = self
        bottomSheet.isModalInPresentation = true
        if let sheet = bottomSheet.sheetPresentationController {
            sheet.detents = [.medium(), .large(), .custom(resolver: { context in
                0.26 * context.maximumDetentValue
            })]
            sheet.prefersGrabberVisible = true
            sheet.preferredCornerRadius = 25
            sheet.largestUndimmedDetentIdentifier = .medium
            sheet.delegate = self
        }
        self.presentVC(vc: bottomSheet)
    }
}

//MARK: - Trip Bottom Sheet Delegate
extension TripViewController: TripBottomSheetViewControllerDelegate {
    func onClickCross() {
        self.dismissOrPop()
    }
}

//MARK: - Sheet Presentation Controller Delegate
extension TripViewController: UISheetPresentationControllerDelegate {
    func sheetPresentationControllerDidChangeSelectedDetentIdentifier(_ sheetPresentationController: UISheetPresentationController) {
        if let selectedDetentIdentifier = sheetPresentationController.selectedDetentIdentifier {
            switch selectedDetentIdentifier {
            case .medium:
                bottomSheet.setUpSheetDetent(detent: .medium)
            case .large:
                bottomSheet.setUpSheetDetent(detent: .large)
            default:
                bottomSheet.setUpSheetDetent(detent: .custom)
            }
        }
    }
}
