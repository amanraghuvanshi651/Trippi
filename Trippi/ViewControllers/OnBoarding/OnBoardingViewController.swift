//
//  ViewController.swift
//  Trippi
//
//  Created by Aman Raghuvanshi on 21/07/23.
//

import UIKit

class OnBoardingViewController: UIViewController {

    //MARK: - Outlets
    @IBOutlet weak var getStartedButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        if let _ = UserDefaults.standard.value(forKey: FIRST_TIME_USER) {
//            navigateToTrippiTabBarVC()
//        }
        getStartedButton.layer.cornerRadius = 25
    }
    
    //methods
    func navigateToTrippiTabBarVC() {
        let vc = getVC(storyboard: .trippiTabBar, vc: TrippiTabBarViewController.identifier) as! TrippiTabBarViewController
        self.pushVC(vc: vc, isAnimated: true)
        
//        guard let vc = getVC(storyboard: .dashboard, vc: DashboardViewController.identifier) as? DashboardViewController else {
//            return
//        }
//        self.pushVC(vc: vc, isAnimated: true)
    }

    //MARK: - Antions
    @IBAction func onClickGetStarted(_ sender: Any) {
        UserDefaults.standard.set(true, forKey: FIRST_TIME_USER)
        navigateToTrippiTabBarVC()
    }
}

