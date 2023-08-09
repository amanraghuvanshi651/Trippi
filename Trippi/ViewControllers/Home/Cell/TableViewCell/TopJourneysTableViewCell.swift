//
//  TopJourneysTableViewCell.swift
//  Trippi
//
//  Created by Aman Raghuvanshi on 28/07/23.
//

import UIKit

protocol TopJourneysTableViewCellDelegate: AnyObject {
    func onClickLikeTopJourney(indexPath: IndexPath, subCellIndexPath: IndexPath)
    func onClickSaveTopJourney(indexPath: IndexPath, subCellIndexPath: IndexPath)
    func didSelectTrip(indexPath: IndexPath, subCellIndexPath: IndexPath)
}

class TopJourneysTableViewCell: UITableViewCell {
    
    var topJourneys = [TopTripModel]()
    weak var delegate: TopJourneysTableViewCellDelegate?
    
    var indexPath = IndexPath()

    //MARK: - Outlet's
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var collectionViewHeightConstraint: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: TopJourneysCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: TopJourneysCollectionViewCell.identifier)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(topJourneys: [TopTripModel]) {
        self.topJourneys = topJourneys
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    //MARK: - Actions
    @IBAction func onClickSeeAll(_ sender: Any) {
    }
}

//MARK: - collection view delegate and datasource
extension TopJourneysTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return topJourneys.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TopJourneysCollectionViewCell.identifier, for: indexPath) as! TopJourneysCollectionViewCell
        cell.delegate = self
        cell.indexPath = indexPath
        cell.configure(topJourney: topJourneys[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row)
        delegate?.didSelectTrip(indexPath: self.indexPath, subCellIndexPath: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / 1.3, height: collectionView.frame.width / 1.5)
    }
}

//MARK: - Collection View cell delegate
extension TopJourneysTableViewCell: TopJourneysCollectionViewCellDelegate {
    func onClickLike(indexPath: IndexPath) {
        self.topJourneys[indexPath.row].isLiked = !self.topJourneys[indexPath.row].isLiked
        delegate?.onClickLikeTopJourney(indexPath: self.indexPath, subCellIndexPath: indexPath)
    }
    
    func onClickSave(indexPath: IndexPath) {
        self.topJourneys[indexPath.row].isSaved = !self.topJourneys[indexPath.row].isSaved
        delegate?.onClickSaveTopJourney(indexPath: self.indexPath, subCellIndexPath: indexPath)
    }
}
