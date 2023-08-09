//
//  CitiesForYouTableViewCell.swift
//  Trippi
//
//  Created by Aman Raghuvanshi on 21/07/23.
//

import UIKit

protocol CitiesForYouTableViewCellDelegate: AnyObject {
    func onClickSeeAll()
    func onDidSelectCity(selectedIndexPath: IndexPath, indexPath: IndexPath)
}

class CitiesForYouTableViewCell: UITableViewCell {
    
    weak var delegate: CitiesForYouTableViewCellDelegate?
    var cities = [HomeCityModel]()
    
    var indexPath = IndexPath()
        
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
    
    func configure(cities: [HomeCityModel], indexPath: IndexPath) {
        self.indexPath = indexPath
        self.cities = cities
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    //MARK: - Actions
    @IBAction func onClickSeeAll(_ sender: Any) {
        delegate?.onClickSeeAll()
    }
}

//MARK: - CollectionView delegate and dataSource
extension CitiesForYouTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cities.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CityCollectionViewCell.identifier, for: indexPath) as! CityCollectionViewCell
        cell.configure(city: cities[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.onDidSelectCity(selectedIndexPath: indexPath, indexPath: self.indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width / 2 - 60 , height: collectionView.frame.size.width / 2)
    }
    
}
