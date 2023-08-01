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
    
    //location
    var locationStatus = CLAuthorizationStatus.notDetermined
    
    var animator: Animator?
    var selectedCellImageViewSnapshot: UIView?
    
    var settingVC: SettingViewController?
    var searchVC: SearchPlaceViewController?
    
    var isTranformingSearch = false
    var searchStateSmall = false
    
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
    
    //search
    @IBOutlet weak var searchIconWidthConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        
        setUpUI()
        registerCell()
        viewModel.getCurrentLocation()
        
        //init vc
        settingVC = getVC(storyboard: .setting, vc: SettingViewController.identifier) as? SettingViewController
        searchVC = getVC(storyboard: .searchPlace, vc: SearchPlaceViewController.identifier) as? SearchPlaceViewController
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapBackGroundView))
        view.addGestureRecognizer(tapGesture)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    //MARK: - Actions
    @IBAction func onClickProfileButton(_ sender: Any) {
        isTranformingSearch = false
        guard let vc = settingVC else { return }
        vc.transitioningDelegate = self
        self.presentVC(vc: vc)
    }
    
    @IBAction func onClickSearch(_ sender: Any) {
        isTranformingSearch = true
        guard let vc = searchVC else { return }
        vc.transitioningDelegate = self
        self.presentVC(vc: vc)
    }
    
    //MARK: - Custom Methods
    @objc func didTapBackGroundView() {
        view.endEditing(true)
    }
    
    func setUpUI() {
        setUpLottieAnimationView()
        searchTextFieldContainerView.layer.cornerRadius = 15
        profileButton.layer.cornerRadius = 15
        badgeView.layer.cornerRadius = 6
    }
    
    func setUpLottieAnimationView() {
        switch locationStatus {
        case .authorizedWhenInUse, .authorizedAlways:
            UIView.animate(withDuration: 0.3) {
                self.lottieAnimationView.alpha = 0
            } completion: { _ in
                self.lottieAnimationView.isHidden = true
            }
        default:
            lottieAnimationView.isHidden = false
            lottieAnimationView.contentMode = .scaleAspectFit
            lottieAnimationView.loopMode = .loop
            lottieAnimationView.animationSpeed = 0.5
            lottieAnimationView.backgroundColor = .clear
            locationLabel.text = "You're in parts unknown"
            lottieAnimationView.play()
            UIView.animate(withDuration: 0.3) {
                self.lottieAnimationView.alpha = 1
            }
        }
    }
    
    //MARK: Register Cell
    func registerCell() {
        tableView.separatorStyle = .none
        tableView.register(UINib(nibName: CitiesForYouTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: CitiesForYouTableViewCell.identifier)
        tableView.register(UINib(nibName: CreateNewTripTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: CreateNewTripTableViewCell.identifier)
        tableView.register(UINib(nibName: TopJourneysTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: TopJourneysTableViewCell.identifier)
        tableView.register(UINib(nibName: MomentTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: MomentTableViewCell.identifier)
    }
    
    //MARK: Header UI
    func setUpLargeHeaderUI() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            UIView.animate(withDuration: 0.2) { [weak self] in
                guard let self = self else { return }
                
                self.searchTextField.font = UIFont(name: "Montserrat Thin Regular", size: 14)
                self.profileButtonHeightConstraint.constant = self.largeProfileButtonHeight
                self.profileButtonWidthConstraint.constant = self.largeProfileButtonHeight
                self.profileButtonBottomConstraint.constant = self.largeProfileBottomConstraint
                
                self.profileButton.layer.cornerRadius = 15
                self.badgeViewHeightConstriant.constant = 12
                self.badgeViewWidthConstraint.constant = 12
                self.badgeView.layer.cornerRadius = 6
                
                self.searchTextFieldContainerStackTrailingConstraint.constant = self.largeSearchTrailingConstant
                
                self.searchIconWidthConstraint.constant = 30
                
                self.stickyHeaderHeightConstraint.constant = self.maxHeaderHeight
                self.view.layoutIfNeeded()
            } completion: { _ in
            }
        }
    }
    
    func setUpSmallHeaderUI() {
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.2) { [weak self] in
                guard let self = self else { return }
                self.searchTextField.font = UIFont(name: "Montserrat Thin Regular", size: 13)
                
                self.searchTextFieldContainerStackTrailingConstraint.constant = self.smallSearchTrailingConstant
                self.searchTextFieldContainerStackTrailingConstraint.constant = self.smallSearchTrailingConstant
                
                self.profileButtonHeightConstraint.constant = self.smallProfileButtonHeight
                self.profileButtonWidthConstraint.constant = self.smallProfileButtonHeight
                self.profileButtonBottomConstraint.constant = self.smallProfileBottomConstraint
                
                self.searchIconWidthConstraint.constant = 25
                
                self.profileButton.layer.cornerRadius = 12
                self.badgeViewHeightConstriant.constant = 11
                self.badgeViewWidthConstraint.constant = 11
                self.badgeView.layer.cornerRadius = 5.5
                
                self.view.layoutIfNeeded()
            } completion: { _ in
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

//MARK: - View Model Delegate
extension HomeViewController: HomeViewModelDelegate {
    func currentLocation(location: String, status: CLAuthorizationStatus) {
        self.locationStatus = status
        self.setUpLottieAnimationView()
        self.locationLabel.text = "You're in \(location)"
    }
    
    func showAlert() {
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
            cell.collectionViewHeightConstraint.constant = cell.collectionView.bounds.width / 1.8
            cell.collectionView.reloadData()
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: CreateNewTripTableViewCell.identifier) as! CreateNewTripTableViewCell
            cell.selectionStyle = .none
            cell.delegate = self
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: TopJourneysTableViewCell.identifier) as! TopJourneysTableViewCell
            cell.selectionStyle = .none
            cell.selectionStyle = .none
            cell.frame = tableView.bounds
            cell.layoutIfNeeded()
            cell.collectionViewHeightConstraint.constant = cell.collectionView.bounds.width / 1.5
            cell.collectionView.reloadData()
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: MomentTableViewCell.identifier, for: indexPath) as! MomentTableViewCell
            cell.configure(imageHeight: tableView.bounds.width + 50)
            return cell
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let scrollDiff = (scrollView.contentOffset.y - previousScrollOffset)
        let isScrollingDown = scrollDiff > 0
        let isScrollingUp = scrollDiff < 0
        var newHeight = stickyHeaderHeightConstraint.constant
        if isScrollingDown {
            newHeight = max(minHeaderHeight, stickyHeaderHeightConstraint.constant - abs(scrollDiff + 1))
        } else if isScrollingUp {
            newHeight = min(headerHeight, stickyHeaderHeightConstraint.constant + abs(scrollDiff + 1))
        }
        
        if scrollView.contentOffset.y == 0 && stickyHeaderHeightConstraint.constant <= maxHeaderHeight {
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

//MARK: - CreateNewTrip Cell Delegate
extension HomeViewController: CreateNewTripTableViewCellDelegate {
    func onClickCreateTripButton() {
        let vc = getVC(storyboard: .createTrip, vc: CreateTripViewController.identifier) as! CreateTripViewController
        self.navigationController?.presentVC(vc: vc)
    }
}

//MARK: - Transitioning Delegate
extension HomeViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if let settingViewController = presented as? SettingViewController {
            selectedCellImageViewSnapshot = profileButtonContainerView.snapshotView(afterScreenUpdates: true)
            animator = Animator(type: .present, firstViewController: self, fromView: profileButtonContainerView, secondViewController: settingViewController, toView: settingViewController.profileButton, selectedCellImageViewSnapshot: selectedCellImageViewSnapshot ?? UIView())
        } else if let searchViewController = presented as? SearchPlaceViewController {
            selectedCellImageViewSnapshot = searchTextFieldContainerView.snapshotView(afterScreenUpdates: true)
            searchViewController.loadView()
            animator = Animator(type: .present, firstViewController: self, fromView: searchTextFieldContainerView, secondViewController: searchViewController, toView: searchViewController.searchTextFieldContainerView, selectedCellImageViewSnapshot: selectedCellImageViewSnapshot ?? UIView())
        }
        
        animator?.delegate = self
        return animator
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        guard let secondViewController = dismissed as? SettingViewController,
              let selectedCellImageViewSnapshot = selectedCellImageViewSnapshot
        else { return nil }
        
        animator = Animator(type: .dismiss, firstViewController: self, fromView: self.profileButtonContainerView, secondViewController: secondViewController, toView: secondViewController.profileButton, selectedCellImageViewSnapshot: selectedCellImageViewSnapshot)
        animator?.delegate = self
        profileButtonContainerView.isHidden = false
        return nil
    }
}

//MARK: - Animator Delegate
extension HomeViewController: AnimatorDelegate {
    func hideFromViewIfNeeded() {
        if !isTranformingSearch {
            profileButtonContainerView.isHidden = true
        }
    }
    
    func unHideFromViewIfNeeded() {
    }
    
    func hideToViewIfNeeded() {
        if !isTranformingSearch {
            self.settingVC?.badgeView.alpha = 0
            self.settingVC?.profileButton.alpha = 0
        } else {
            searchVC?.searchTextFieldContainerView.alpha = 0
        }
    }
    
    func unHideToViewIfNeeded() {
        if !isTranformingSearch {
            UIView.animate(withDuration: 0.3) {
                self.settingVC?.badgeView.alpha = 1
                self.settingVC?.profileButton.alpha = 1
            } completion: { _ in
                self.animator?.imageViewSnapshot.removeFromSuperview()
            }
        } else {
            UIView.animate(withDuration: 0.3) {
                self.searchVC?.searchTextFieldContainerView.layer.cornerRadius = 15
                self.searchVC?.searchTextFieldContainerView.alpha = 1
            } completion: { _ in
                self.animator?.imageViewSnapshot.removeFromSuperview()
            }
        }
    }
}

