//
//  SplashViewController.swift
//  Trippi
//
//  Created by Aman Raghuvanshi on 04/08/23.
//

import UIKit

class SplashViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        if let _ = UserDefaults.standard.value(forKey: FIRST_TIME_USER) {
            navigateToTrippiTabBarVC()
        } else {
            navigateToOnBoardingVC()
        }
    }
    
    func navigateToTrippiTabBarVC() {
        let vc = getVC(storyboard: .trippiTabBar, vc: TrippiTabBarViewController.identifier) as! TrippiTabBarViewController
        self.pushVC(vc: vc, isAnimated: true)
    }
    
    func navigateToOnBoardingVC() {
        let vc = getVC(storyboard: .onBoarding, vc: OnBoardingViewController.identifier) as! OnBoardingViewController
        self.pushVC(vc: vc, isAnimated: true)
    }
}
