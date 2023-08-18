//
//  TripDatesTableViewCell.swift
//  Trippi
//
//  Created by Aman Raghuvanshi on 17/08/23.
//

import UIKit

protocol TripDatesTableViewCellDelegate: AnyObject {
    func onClickDate(tripDate: TripDate, indexPath: IndexPath)
    func onClickAddDate()
}

class TripDatesTableViewCell: UITableViewCell {
    
    weak var delegate: TripDatesTableViewCellDelegate?
    var dates = [TripDate]()
    
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
        return dates.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TripDatesCollectionViewCell.identifier, for: indexPath) as? TripDatesCollectionViewCell else {
            return UICollectionViewCell()
        }
        if indexPath.row == dates.count {
            cell.configureAddButton()
        } else {
            cell.configure(tripDate: dates[indexPath.row])
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == dates.count {
            delegate?.onClickAddDate()
        } else {
            delegate?.onClickDate(tripDate: dates[indexPath.row], indexPath: indexPath)
        }
    }
}
