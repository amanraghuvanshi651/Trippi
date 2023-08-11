//
//  PlannedTripTableViewCell.swift
//  Trippi
//
//  Created by macmini50 on 11/08/23.
//

import UIKit

class PlannedTripTableViewCell: UITableViewCell {

    //MARK: - Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: PlannedTripCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: PlannedTripCollectionViewCell.identifier)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}


//MARK: - Collection View Delegate and Datasource
extension PlannedTripTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PlannedTripCollectionViewCell.identifier, for: indexPath) as! PlannedTripCollectionViewCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.width / 2), height: (collectionView.frame.width / 2) + 50)
    }
}
