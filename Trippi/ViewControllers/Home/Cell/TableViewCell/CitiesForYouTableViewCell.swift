//
//  CitiesForYouTableViewCell.swift
//  Trippi
//
//  Created by Aman Raghuvanshi on 21/07/23.
//

import UIKit

protocol CitiesForYouTableViewCellDelegate: AnyObject {
    func onClickSeeAll()
}

class CitiesForYouTableViewCell: UITableViewCell {
    static let identifier = "CitiesForYouTableViewCell"
    
    weak var delegate: CitiesForYouTableViewCellDelegate?
        
    //MARK: - Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var collectionViewHeightConstraint: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.register(UINib(nibName: CityCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: CityCollectionViewCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    //MARK: - Actions
    @IBAction func onClickSeeAll(_ sender: Any) {
        delegate?.onClickSeeAll()
    }
}

//MARK: - CollectionView delegate and dataSource
extension CitiesForYouTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CityCollectionViewCell.identifier, for: indexPath) as! CityCollectionViewCell
        cell.cityImageViewHeightConstraint.constant = collectionView.frame.size.width / 2 - 80
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width / 2 - 60 , height: collectionView.frame.size.width / 1.8)
    }
    
}
