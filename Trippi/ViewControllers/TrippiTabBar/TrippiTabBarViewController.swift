//
//  TrippiTabBarViewController.swift
//  Trippi
//
//  Created by Aman Raghuvanshi on 04/08/23.
//

import UIKit

class TrippiTabBarViewController: UIViewController {

    var selectedItem = 0
    
    
    var isInitialViewLoaded = false
    
    var items = [
        TrippiTabBarItem(title: "Dashboard", image: "TabBarDashboard"),
        TrippiTabBarItem(title: "Discovery", image: "TabBarDiscovery"),
        TrippiTabBarItem(title: "Profile", image: "TabBarProfile")
    ]
    
    //view controllers
    var home: HomeViewController = {
        let vc = getVC(storyboard: .home, vc: HomeViewController.identifier) as! HomeViewController
        vc.view.alpha = 0
        return vc
    }()
    var dashboard: DiscoveryViewController = {
        let vc = getVC(storyboard: .discovery, vc: DiscoveryViewController.identifier) as! DiscoveryViewController
        vc.view.alpha = 0
        return vc
    }()
    var profile: ProfileViewController = {
        let vc = getVC(storyboard: .profile, vc: ProfileViewController.identifier) as! ProfileViewController
        vc.view.alpha = 0
        return vc
    }()
    
    //MARK: - Outlets
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var addButton: UIButton!
    
    //tab bar
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tabBarContainerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBarContainerView.layer.cornerRadius = 30
        addButton.layer.cornerRadius = 30
        
        collectionView.register(UINib(nibName: TrippiTabBarItemCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: TrippiTabBarItemCollectionViewCell.identifier)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setUpItemWidth()
    }
    
    //MARK: - Actions
    @IBAction func onClickAddButton(_ sender: Any) {
        let vc = getVC(storyboard: .createTrip, vc: CreateTripViewController.identifier) as! CreateTripViewController
        self.navigationController?.presentVC(vc: vc)
    }
    
    //MARK: - Custom Methods
    func remove() {
        self.containerView.subviews.forEach { subView in
            if subView == home.view || subView == dashboard.view || subView == profile.view {
                UIView.animate(withDuration: 0.2,
                               animations: {subView.alpha = 0.0},
                               completion: {(value: Bool) in
                    subView.removeFromSuperview()
                })
            }
        }
    }
    
    func setUpItemWidth() {
        if !isInitialViewLoaded {
            addHomeVC()
            isInitialViewLoaded = true
        }
    }
    
    func addHomeVC() {
        home.delegate = self
        self.containerView.addSubview(self.home.view)
        self.home.accessibilityFrame = self.containerView.frame
        self.home.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.home.didMove(toParent: self)
        UIView.animate(withDuration: 0.2,
                       animations: {self.home.view.alpha = 1},
                       completion: {(value: Bool) in
        })
    }
    
    func addDashboardVC() {
        self.containerView.addSubview(self.dashboard.view)
        self.dashboard.accessibilityFrame = self.containerView.frame
        self.dashboard.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.dashboard.didMove(toParent: self)
        UIView.animate(withDuration: 0.2,
                       animations: {self.dashboard.view.alpha = 1},
                       completion: {(value: Bool) in
        })
    }
    
    func addProfileVC() {
        self.containerView.addSubview(self.profile.view)
        self.profile.accessibilityFrame = self.containerView.frame
        self.profile.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.profile.didMove(toParent: self)
        UIView.animate(withDuration: 0.2,
                       animations: {self.profile.view.alpha = 1},
                       completion: {(value: Bool) in
        })
    }
}

//MARK: - Collection View delegate and datasource
extension TrippiTabBarViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TrippiTabBarItemCollectionViewCell.identifier, for: indexPath) as! TrippiTabBarItemCollectionViewCell
        cell.configure(item: items[indexPath.row], isSelected: selectedItem == indexPath.row)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let lastSelectedCell = collectionView.cellForItem(at: IndexPath(row: selectedItem, section: 0)) as! TrippiTabBarItemCollectionViewCell
        let currentCell = collectionView.cellForItem(at: indexPath) as! TrippiTabBarItemCollectionViewCell
        selectedItem = indexPath.row
        
        collectionView.collectionViewLayout.invalidateLayout()
        lastSelectedCell.containerView.backgroundColor = .clear
        currentCell.containerView.backgroundColor = UIColor(named: BUTTON_BACKGROUND_COLOR)
        UIView.animate(withDuration: 0.4) {
            collectionView.layoutIfNeeded()
            lastSelectedCell.updateUI(isSelected: false)
            currentCell.updateUI(isSelected: true)
        }
        
        self.remove()
        
        // Add the child's View as a subview
        switch indexPath.row {
        case 0:
            addHomeVC()
        case 1:
            addDashboardVC()
        case 2:
            addProfileVC()
        default:
            addHomeVC()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let selectedItemWidth = (collectionView.frame.width / Double(items.count)) + 50
        let defaultWidth = (collectionView.frame.width - selectedItemWidth) / Double(items.count - 1)
        return CGSize(width: selectedItem == indexPath.row ? selectedItemWidth : defaultWidth, height: collectionView.bounds.height)
    }
}

//MARK: - Home Delegate
extension TrippiTabBarViewController: HomeViewControllerDelegate {
    func pushTripVC() {
        let vc = getVC(storyboard: .trip, vc: TripViewController.identifier)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func hideAddButton() {
        UIView.animate(withDuration: 0.3) {
            self.addButton.alpha = 0
        } completion: { _ in
            self.addButton.isHidden = true
        }
    }
    
    func unHideAddButton() {
        if addButton.isHidden {
            addButton.isHidden = false
            UIView.animate(withDuration: 0.3) {
                self.addButton.alpha = 1
            }
        }
    }
    
    func presentShareVC() {
        let vc = getVC(storyboard: .share, vc: ShareViewController.identifier) as! ShareViewController
        self.navigationController?.presentVC(vc: vc)
    }
    
    func presentCommentsVC() {
        let vc = getVC(storyboard: .comments, vc: CommentsViewController.identifier) as! CommentsViewController
        self.navigationController?.presentVC(vc: vc)
    }
}
