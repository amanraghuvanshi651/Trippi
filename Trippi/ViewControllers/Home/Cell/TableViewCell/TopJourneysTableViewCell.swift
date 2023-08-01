//
//  TopJourneysTableViewCell.swift
//  Trippi
//
//  Created by Aman Raghuvanshi on 28/07/23.
//

import UIKit

class TopJourneysTableViewCell: UITableViewCell {

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
    
    //MARK: - Actions
    @IBAction func onClickSeeAll(_ sender: Any) {
    }
}

//MARK: - collection view delegate and datasource
extension TopJourneysTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TopJourneysCollectionViewCell.identifier, for: indexPath) as! TopJourneysCollectionViewCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / 1.3, height: collectionView.frame.width / 1.5)
    }
    
}
