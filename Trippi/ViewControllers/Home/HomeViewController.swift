//
//  HomeViewController.swift
//  Trippi
//
//  Created by Aman Raghuvanshi on 21/07/23.
//

import UIKit
import CoreLocation
import Lottie

class HomeViewController: UIViewController {
    static let identifier = "HomeViewController"
    
    private var viewModel = HomeViewModel()
        
    //header
    let maxHeaderHeight: CGFloat = 170
    let headerHeight: CGFloat = 80
    let minHeaderHeight: CGFloat = 0
    var previousScrollOffset: CGFloat = 0
    
    var largeProfileButtonHeight: CGFloat = 60
    var smallProfileButtonHeight: CGFloat = 50
    
    var largeProfileBottomConstraint: CGFloat = 90
    var smallProfileBottomConstraint: CGFloat = 10
    
    var largeSearchTrailingConstant: CGFloat = 60
    var smallSearchTrailingConstant: CGFloat = -10
    
    var isAnimationInProgress = false
    
    //location
    let locationManager = CLLocationManager()
    var location = (0.0, 0.0)
    
    var animator: Animator?
    var selectedCellImageViewSnapshot: UIView?
    
    //MARK: - Outlets
    @IBOutlet weak var discoveryLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    //header view
    @IBOutlet weak var stickyHeader: UIView!
    @IBOutlet weak var searchTextFieldContainerView: UIView!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var lottieAnimationView: LottieAnimationView!
    
    @IBOutlet weak var stickyHeaderHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var searchTextFieldContainerStackTrailingConstraint: NSLayoutConstraint!
    
    //profile
    @IBOutlet weak var badgeView: UIView!
    @IBOutlet weak var profileButton: UIButton!
    @IBOutlet weak var profileButtonContainerView: UIView!
    
    @IBOutlet weak var badgeViewHeightConstriant: NSLayoutConstraint!
    @IBOutlet weak var badgeViewWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var profileButtonHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var profileButtonWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var profileButtonBottomConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
        setUpUI()
        locationManager.delegate = self
        getCurrentLocation()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapBackGroundView))
        view.addGestureRecognizer(tapGesture)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        selectedCellImageViewSnapshot = profileButtonContainerView.snapshotView(afterScreenUpdates: true)
    }
    
    //MARK: - Actions
    @IBAction func onClickProfileButton(_ sender: Any) {
        let vc = getVC(storyboard: .setting, vc: SettingViewController.identifier) as! SettingViewController
        vc.transitioningDelegate = self
        self.presentVC(vc: vc)
    }
    
    //MARK: - Custom Methods
    
    @objc func didTapBackGroundView() {
        view.endEditing(true)
    }
    
    func setUpUI() {
        switch self.locationManager.authorizationStatus {
        case .authorizedWhenInUse, .authorizedAlways:
            lottieAnimationView.isHidden = true
        default:
            lottieAnimationView.isHidden = false
            lottieAnimationView.contentMode = .scaleAspectFit
            lottieAnimationView.loopMode = .loop
            lottieAnimationView.animationSpeed = 0.5
            lottieAnimationView.backgroundColor = .clear
            lottieAnimationView.play()
        }
        
        searchTextFieldContainerView.layer.cornerRadius = 15
        profileButton.layer.cornerRadius = 15
        badgeView.layer.cornerRadius = 6
    }
    
    //MARK: Register Cell
    func registerCell() {
        tableView.separatorStyle = .none
        tableView.register(UINib(nibName: CitiesForYouTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: CitiesForYouTableViewCell.identifier)
        tableView.register(UINib(nibName: CreateNewTripTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: CreateNewTripTableViewCell.identifier)
    }
    
    //MARK: Header UI
    func setUpLargeHeaderUI() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.discoveryLabel.isHidden = false
            self.locationLabel.isHidden = false
            switch self.locationManager.authorizationStatus {
            case .authorizedWhenInUse, .authorizedAlways:
                self.lottieAnimationView.isHidden = true
            default:
                self.lottieAnimationView.isHidden = false
            }
            self.isAnimationInProgress = true
            UIView.animate(withDuration: 0.2) { [weak self] in
                guard let self = self else { return }
                self.discoveryLabel.alpha = 1
                self.locationLabel.alpha = 1
                self.lottieAnimationView.alpha = 1
                
                self.profileButtonHeightConstraint.constant = self.largeProfileButtonHeight
                self.profileButtonWidthConstraint.constant = self.largeProfileButtonHeight
                self.profileButtonBottomConstraint.constant = self.largeProfileBottomConstraint
                
                self.profileButton.layer.cornerRadius = 15
                self.badgeViewHeightConstriant.constant = 12
                self.badgeViewWidthConstraint.constant = 12
                self.badgeView.layer.cornerRadius = 6
                
                self.searchTextFieldContainerStackTrailingConstraint.constant = self.largeSearchTrailingConstant
                
                self.stickyHeaderHeightConstraint.constant = self.maxHeaderHeight
                self.view.layoutIfNeeded()
            } completion: { _ in
                self.isAnimationInProgress = false
            }
        }
    }
    
    func setUpSmallHeaderUI() {
        DispatchQueue.main.async {
            self.isAnimationInProgress = true
            UIView.animate(withDuration: 0.2) { [weak self] in
                guard let self = self else { return }
                self.searchTextFieldContainerStackTrailingConstraint.constant = self.smallSearchTrailingConstant
                self.searchTextFieldContainerStackTrailingConstraint.constant = self.smallSearchTrailingConstant
                
                self.profileButtonHeightConstraint.constant = self.smallProfileButtonHeight
                self.profileButtonWidthConstraint.constant = self.smallProfileButtonHeight
                self.profileButtonBottomConstraint.constant = self.smallProfileBottomConstraint
                
                self.profileButton.layer.cornerRadius = 12
                self.badgeViewHeightConstriant.constant = 11
                self.badgeViewWidthConstraint.constant = 11
                self.badgeView.layer.cornerRadius = 5.5
                
                self.discoveryLabel.alpha = 0
                self.locationLabel.alpha = 0
                self.lottieAnimationView.alpha = 0
                self.view.layoutIfNeeded()
            } completion: { _ in
                self.isAnimationInProgress = false
                self.discoveryLabel.isHidden = true
                self.locationLabel.isHidden = true
                self.lottieAnimationView.isHidden = true
            }
        }
    }
    
    //MARK: location
    func getCurrentLocation() {
        DispatchQueue.global().async {
            switch self.locationManager.authorizationStatus {
            case .authorizedWhenInUse, .authorizedAlways:
                if let currentLocation:CLLocation = self.locationManager.location {
                    self.location.0 = currentLocation.coordinate.latitude
                    self.location.1 = currentLocation.coordinate.longitude
                    self.getReversedGeoLocation(location: currentLocation)
                }
            default:
                self.locationManager.requestLocation()
                break
            }
        }
    }
    
    func getReversedGeoLocation(location : CLLocation) {
        CLGeocoder().reverseGeocodeLocation(location) {
            placemarks , error in
            if error == nil && placemarks!.count > 0 {
                guard let placemark = placemarks?.last else {
                    return
                }
                let reversedGeoLocation = ReversedGeoLocation(with: placemark)
                self.locationLabel.text = "You're in \(reversedGeoLocation.city)"
            }
        }
    }
    
    //MARK: Alert
    func showLocationSettingAlert() {
        let alert = UIAlertController(title: "Location Permission", message: "Allow Location Permission from settings to personalize your experience.", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "settings", style: UIAlertAction.Style.default, handler: { _ in
            UIApplication.shared.open(URL(string:UIApplication.openSettingsURLString)!)
        }))
        alert.addAction(UIAlertAction(title: "cancel", style: UIAlertAction.Style.cancel, handler: { _ in
            alert.dismiss(animated: true)
        }))
        self.present(alert, animated: true, completion: nil)
    }
}

//MARK: - CLLocation Delegate
extension HomeViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        setUpUI()
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        location.0 = locValue.latitude
        location.1 = locValue.longitude
        getReversedGeoLocation(location: CLLocation(latitude: locValue.latitude, longitude: locValue.longitude))
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        showLocationSettingAlert()
    }
}

//MARK: - TableView Delegate and DataSource
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: CitiesForYouTableViewCell.identifier, for: indexPath) as! CitiesForYouTableViewCell
            cell.selectionStyle = .none
            cell.frame = tableView.bounds
            cell.layoutIfNeeded()
            cell.collectionViewHeightConstraint.constant = cell.collectionView.bounds.width / 1.7
            cell.collectionView.reloadData()
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: CreateNewTripTableViewCell.identifier) as! CreateNewTripTableViewCell
            cell.delegate = self
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: CitiesForYouTableViewCell.identifier, for: indexPath) as! CitiesForYouTableViewCell
            cell.selectionStyle = .none
            cell.frame = tableView.bounds
            cell.layoutIfNeeded()
            cell.collectionViewHeightConstraint.constant = cell.collectionView.bounds.width / 1.7
            cell.collectionView.reloadData()
            return cell
        }
    }
    
    func canAnimateHeader (_ scrollView: UIScrollView) -> Bool {
        let scrollViewMaxHeight = scrollView.frame.height + self.stickyHeaderHeightConstraint.constant - minHeaderHeight
        return scrollView.contentSize.height > scrollViewMaxHeight
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let scrollDiff = (scrollView.contentOffset.y - previousScrollOffset)
        let isScrollingDown = scrollDiff > 0
        let isScrollingUp = scrollDiff < 0
        if canAnimateHeader(scrollView) {
            var newHeight = stickyHeaderHeightConstraint.constant
            if isScrollingDown {
                newHeight = max(minHeaderHeight, stickyHeaderHeightConstraint.constant - abs(scrollDiff + 1))
            } else if isScrollingUp {
                newHeight = min(headerHeight, stickyHeaderHeightConstraint.constant + abs(scrollDiff + 1))
            }
            
            if scrollView.contentOffset.y == 0 && stickyHeaderHeightConstraint.constant <= maxHeaderHeight && !isAnimationInProgress {
                setUpLargeHeaderUI()
            } else if !self.locationLabel.isHidden && self.locationLabel.alpha == 1 {
                print(scrollView.contentOffset.y)
                setUpSmallHeaderUI()
            }
            
            if newHeight != stickyHeaderHeightConstraint.constant || isScrollingDown {
                stickyHeaderHeightConstraint.constant = newHeight
            }
            
            previousScrollOffset = scrollView.contentOffset.y
        }
    }
}

//MARK: - CreateNewTrip Cell Delegate
extension HomeViewController: CreateNewTripTableViewCellDelegate {
    func onClickCreateTripButton() {
    }
}

//MARK: - Transitioning Delegate
extension HomeViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        guard let secondViewController = presented as? SettingViewController,
              let selectedCellImageViewSnapshot = selectedCellImageViewSnapshot
        else { return nil }
        
        animator = Animator(type: .present, firstViewController: self, secondViewController: secondViewController, selectedCellImageViewSnapshot: selectedCellImageViewSnapshot)
        return animator
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        guard let secondViewController = dismissed as? SettingViewController,
              let selectedCellImageViewSnapshot = selectedCellImageViewSnapshot
        else { return nil }
        
        animator = Animator(type: .dismiss, firstViewController: self, secondViewController: secondViewController, selectedCellImageViewSnapshot: selectedCellImageViewSnapshot)
        
        profileButtonContainerView.isHidden = false
        return nil
    }
}

