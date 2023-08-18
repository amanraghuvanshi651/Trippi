//
//  TripDatesTableViewCell.swift
//  Trippi
//
//  Created by macmini50 on 17/08/23.
//

import UIKit

class TripDatesTableViewCell: UITableViewCell {
    
    @IBOutlet weak var collectionView: UICollectionView!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: TripDatesCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: TripDatesCollectionViewCell.identifier)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}

extension TripDatesTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TripDatesCollectionViewCell.identifier, for: indexPath) as? TripDatesCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.configure(date: Date())
        return cell
    }
}
