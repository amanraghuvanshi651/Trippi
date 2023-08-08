//
//  HomeViewController.swift
//  Trippi
//
//  Created by Aman Raghuvanshi on 21/07/23.
//

import UIKit
import CoreLocation
import Lottie

protocol HomeViewControllerDelegate: AnyObject {
    func presentShareVC()
    func presentCommentsVC()
}

class HomeViewController: UIViewController {
    
    weak var delegate: HomeViewControllerDelegate?
    private var viewModel = HomeViewModel()
    
    var animationSpeed = 0.8
    
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
    
    //static data
    var homeData = [HomeDataModel]()
    
    var cities = [
        HomeCityModel(image: "NewYork", city: "New York", country: "USA"),
        HomeCityModel(image: "Pairs", city: "Pairs", country: "France"),
        HomeCityModel(image: "Moscow", city: "Moscow", country: "Russia"),
        HomeCityModel(image: "Delhi", city: "Delhi", country: "India"),
        HomeCityModel(image: "Seoul", city: "Seoul", country: "South Korea")
    ]
    
    var topJourneys = [
        TopTripModel(image: "TripImage1", title: "Wanderlust Whispers: A Journey through Time and Nature", description: "Embark on an enchanting odyssey, traversing ancient realms and unspoiled landscapes, as history unfolds and nature's wonders beckon.", isLiked: false, isSaved: false),
        TopTripModel(image: "TripImage2", title: "Cosmic Trails: Exploring the Universe's Hidden Gems", description: "Venture beyond the celestial veil, gazing at stars and galaxies, uncovering cosmic secrets in a quest of astronomical exploration.", isLiked: false, isSaved: false),
        TopTripModel(image: "TripImage3", title: "Dreamscapes Unveiled: Adventures Beyond Imagination"
                     , description: "Unravel surreal vistas, where dreams take form and reality blurs, igniting an unforgettable expedition through the ethereal.", isLiked: false, isSaved: false),
        TopTripModel(image: "TripImage4", title: "Pathways of Serenity: Escaping to Tranquil Havens"
                     , description: "Embrace serene sanctuaries, where time stands still, and the soul finds solace amidst nature's tranquil embrace.", isLiked: false, isSaved: false),
        TopTripModel(image: "TripImage5", title: "Cultural Kaleidoscope: Diverse Encounters Worldwide"
                     , description: "Embrace vibrant cultures and traditions, as diverse landscapes interweave with captivating stories of humanity's heritage.", isLiked: false, isSaved: false),
        TopTripModel(image: "TripImage6", title: "Enchanted Escapades: Unraveling Mystical Destinations"
                     , description: "Step into realms of magic and myth, where legends come alive and enchantment awaits at every turn.", isLiked: false, isSaved: false)
    ]
    
    var moments = [
        MomentModel(image: "Moment1", userPic: "User", username: "teddy_yo", description: "🎭 Immerse in cultural festivities, vibrant traditions, and celebratory spirits. #CulturalDiversity #FestiveVibes 🎉", isFollowing: false, isLiked: false, isSaved: false),
        MomentModel(image: "Moment2", userPic: "User", username: "spy.me", description: "🌴 Tropical Paradise Found! Join us for sun-soaked days and island adventures. #Wanderlust #TravelGoals 🏝️", isFollowing: false, isLiked: false, isSaved: false),
        MomentModel(image: "Moment3", userPic: "User", username: "angry.guy", description: "🏔️ Calling all thrill-seekers! Conquer mountains and discover breathtaking vistas. #AdventureAwaits #NatureLover 🚵‍♂️", isFollowing: false, isLiked: false, isSaved: false),
        MomentModel(image: "Moment4", userPic: "User", username: "sam.the.boi", description: "🏰 Step back in time and explore ancient ruins. History buffs, this one's for you! #TimeTravel #CulturalHeritage 🗿", isFollowing: false, isLiked: false, isSaved: false),
        MomentModel(image: "Moment5", userPic: "User", username: "someone.in.the.game", description: "🌊 Dive into crystal waters, swim with marine life, and witness ocean magic. 🐠🐢 #UnderwaterAdventure #ScubaDiving 🌊", isFollowing: false, isLiked: false, isSaved: false),
        MomentModel(image: "Moment6", userPic: "User", username: "theridingboots", description: "🍽️ Foodie's delight! Savor local cuisines, culinary wonders, and mouthwatering delicacies. #FoodAdventures #GourmetEats 🍲", isFollowing: false, isLiked: false, isSaved: false),
        MomentModel(image: "Moment7", userPic: "User", username: "capture.view", description: "🏛️ Marvel at architectural wonders that stand the test of time. Explore the world's heritage. #ArchitecturalMarvels #TravelHistory 🏛️", isFollowing: false, isLiked: false, isSaved: false),
        MomentModel(image: "Moment8", userPic: "User", username: "crazy.guy", description: "🛶 Paddle through serene waters, escape to hidden coves, and embrace nature's tranquility. #Kayaking #NatureEscape 🌿", isFollowing: false, isLiked: false, isSaved: false),
        MomentModel(image: "Moment9", userPic: "User", username: "guy.com", description: "🌌 Stargazers unite! Experience the cosmos in all its brilliance. #AstronomyLovers #StarryNights ✨", isFollowing: false, isLiked: false, isSaved: false)
    ]
    
    //MARK: - Outlets
    @IBOutlet weak var discoveryLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    //header view
    @IBOutlet weak var stickyHeader: UIView!
    @IBOutlet weak var searchTextFieldContainerView: UIView!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var lottieAnimationView: LottieAnimationView!
    
    @IBOutlet weak var shareImage: UIImageView!
    
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
        
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 120, right: 0)
        
        setUpHomeData(moments: moments, cities: cities, topJourneys: topJourneys)
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
    
    func setUpHomeData(moments: [MomentModel], cities: [HomeCityModel], topJourneys: [TopTripModel]) {
        //appending 2 moments
        if moments.count > 2 {
            for idx in 0..<2 {
                homeData.append(HomeDataModel(type: .moment, data: moments[idx]))
            }
        }
        
        //appending cities data
        homeData.append(HomeDataModel(type: .city, data: cities))
        
        //appending 2 moments
        if moments.count > 4 {
            for idx in 2..<4 {
                homeData.append(HomeDataModel(type: .moment, data: moments[idx]))
            }
        }
        
        //appending top journeys data
        homeData.append(HomeDataModel(type: .topJourney, data: topJourneys))
        
        //appending remaining moments
        for idx in 4..<moments.count {
            homeData.append(HomeDataModel(type: .moment, data: moments[idx]))
        }
        
        reloadTableView()
    }
    
    func reloadTableView() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.tableView.reloadData()
        }
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
        return homeData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = homeData[indexPath.row]
        
        switch data.type {
        case .city:
            if let citiesData = data.data as? [HomeCityModel] {
                let cell = tableView.dequeueReusableCell(withIdentifier: CitiesForYouTableViewCell.identifier, for: indexPath) as! CitiesForYouTableViewCell
                cell.configure(cities: citiesData)
                
                cell.selectionStyle = .none
                cell.frame = tableView.bounds
                cell.layoutIfNeeded()
                cell.collectionViewHeightConstraint.constant = cell.collectionView.bounds.width / 2
                cell.collectionView.reloadData()
                return cell
            }
        case .topJourney:
            if let topJourneysData = data.data as? [TopTripModel] {
                let cell = tableView.dequeueReusableCell(withIdentifier: TopJourneysTableViewCell.identifier) as! TopJourneysTableViewCell
                cell.indexPath = indexPath
                cell.configure(topJourneys: topJourneysData)
                cell.delegate = self
                
                cell.selectionStyle = .none
                cell.frame = tableView.bounds
                cell.layoutIfNeeded()
                cell.collectionViewHeightConstraint.constant = cell.collectionView.bounds.width / 1.5
                cell.collectionView.reloadData()
                return cell
            }
        case .moment:
            if let moment = data.data as? MomentModel {
                let cell = tableView.dequeueReusableCell(withIdentifier: MomentTableViewCell.identifier, for: indexPath) as! MomentTableViewCell
                cell.delegate = self
                cell.configure(moment: moment,imageHeight: tableView.bounds.width + 50, indexPath: indexPath)
                return cell
            }
        }
        return UITableViewCell()
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
            setUpSmallHeaderUI()
        }
        
        if newHeight != stickyHeaderHeightConstraint.constant || isScrollingDown {
            stickyHeaderHeightConstraint.constant = newHeight
        }
        
        previousScrollOffset = scrollView.contentOffset.y
    }
}

//MARK: - Top Journey Cell Delegate
extension HomeViewController: TopJourneysTableViewCellDelegate {
    func onClickLikeTopJourney(indexPath: IndexPath, subCellIndexPath: IndexPath) {
        let data = homeData[indexPath.row]
        var topJourneysData = data.data as? [TopTripModel]
        let isLiked = topJourneysData?[subCellIndexPath.row].isLiked ?? false
        topJourneysData?[subCellIndexPath.row].isLiked = !isLiked
        homeData[indexPath.row].data = topJourneysData ?? [TopTripModel]()
    }
    
    func onClickSaveTopJourney(indexPath: IndexPath, subCellIndexPath: IndexPath) {
        let data = homeData[indexPath.row]
        var topJourneysData = data.data as? [TopTripModel]
        let isSaved = topJourneysData?[subCellIndexPath.row].isSaved ?? false
        topJourneysData?[subCellIndexPath.row].isSaved = !isSaved
        homeData[indexPath.row].data = topJourneysData ?? [TopTripModel]()
    }
}

//MARK: - Moment Cell Delegate
extension HomeViewController: MomentTableViewCellDelegate {
    func onClickFollow() {
    }
    
    func onClickMomentLike() {
    }
    
    func onClickMomentSave() {
    }
    
    func onClickMomentShare(indexPath: IndexPath) {
        DispatchQueue.main.asyncAfter(deadline: .now() + (animationSpeed - 0.42)) {
            self.delegate?.presentShareVC()
        }
        let cell = self.tableView.cellForRow(at: indexPath) as! MomentTableViewCell
        let imageRect = cell.shareButton.convert(cell.shareButton.bounds, to: self.view)
        shareImage.frame = imageRect
        shareImage.isHidden = false

        let path = UIBezierPath()
        path.move(to: CGPoint(x: shareImage.frame.midX, y: shareImage.frame.midY))
        path.addQuadCurve(to: CGPoint(x: shareImage.frame.midX + 80, y: -50), controlPoint: CGPoint(x: shareImage.frame.midX + 80, y: shareImage.frame.midY))

        let animation = CAKeyframeAnimation(keyPath: "position")
        animation.path = path.cgPath
        animation.repeatCount = 0
        animation.duration = animationSpeed
        animation.delegate = self

        shareImage.layer.add(animation, forKey: "animate along path")
        shareImage.center = CGPoint(x: shareImage.frame.midX + 80, y: -50)
        
    }
    
    func onClickMomentComments() {
        delegate?.presentCommentsVC()
    }
}

extension HomeViewController: CAAnimationDelegate {
    func animationDidStart(_ anim: CAAnimation) {
        UIView.animate(withDuration: animationSpeed) {
            self.shareImage.transform = CGAffineTransformMakeScale(2.5, 2.5)
            self.shareImage.transform = self.shareImage.transform.rotated(by: .pi * 1.8)
        }
    }
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        shareImage.isHidden = true
        self.shareImage.transform = .identity
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

