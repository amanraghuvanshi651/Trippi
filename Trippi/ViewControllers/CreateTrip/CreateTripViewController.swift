//
//  CreateTripViewController.swift
//  Trippi
//
//  Created by Aman Raghuvanshi on 27/07/23.
//

import UIKit

class CreateTripViewController: UIViewController {
    static let identifier = "CreateTripViewController"

    //MARK: - Outlets
    @IBOutlet weak var addImageContainerView: UIView!
    
    @IBOutlet weak var topSmallView: UIView!
    @IBOutlet weak var containerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapBackGroundView))
        view.addGestureRecognizer(tapGesture)
        
        addImageContainerView.layer.cornerRadius = 20
        
        containerView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        containerView.layer.cornerRadius = 20
        topSmallView.layer.cornerRadius = 2.5
    }
    
    @objc func didTapBackGroundView() {
        view.endEditing(true)
    }
}
