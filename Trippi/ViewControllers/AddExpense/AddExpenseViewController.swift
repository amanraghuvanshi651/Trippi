//
//  AddExpenseViewController.swift
//  Trippi
//
//  Created by macmini50 on 23/08/23.
//

import UIKit

class AddExpenseViewController: UIViewController {
    
    var expenseTypes = TripExpenseType.allCases
    var addExpenseTypes = [AddExpenseTypeModel]()
    
    var lastSelectedIndexPath: IndexPath?

    //MARK: - Outlets
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var amountContainerView: UIView!
    @IBOutlet weak var amountTextField: UITextField!
    @IBOutlet weak var addButton: UIButton!
    
    @IBOutlet weak var collectionViewHeightConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addExpenseTypes = expenseTypes.map({ expenseType in
            AddExpenseTypeModel(expenseType: expenseType, isSelected: false)
        })
        setUpUI()
    }
}

//MARK: - Actions
extension AddExpenseViewController {
    @IBAction func onClickBackgroundButton(_ sender: Any) {
        self.dismissOrPop()
    }
    
    @IBAction func onClickAddButton(_ sender: Any) {
    }
}

//MARK: - Custom Methods
extension AddExpenseViewController {
    func setUpUI() {
        setCornerRadius(views: [containerView, amountContainerView, addButton])
        containerView.layer.cornerRadius = 10
        amountContainerView.layer.cornerRadius = 10
        addButton.layer.cornerRadius = 10
        
        containerView.addShadow(color: UIColor.black.cgColor, opacity: 0.5, offset: CGSize(width: 0, height: 1), radius: 10)
        
        collectionViewHeightConstraint.constant = CGFloat(ceil(Double(addExpenseTypes.count) / 6) * 50)
        collectionView.register(UINib(nibName: ExpenseTypeCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: ExpenseTypeCollectionViewCell.identifier)
    }
    
    func setCornerRadius(views: [UIView]) {
        views.forEach { view in
            view.layer.cornerRadius = 10
        }
    }
}

//MARK: - Collection View Delegate and Datasource
extension AddExpenseViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        addExpenseTypes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ExpenseTypeCollectionViewCell.identifier, for: indexPath) as? ExpenseTypeCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.configure(expenseType: addExpenseTypes[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        addExpenseTypes[indexPath.row].isSelected = true
        if let lastSelectedIndexPath = lastSelectedIndexPath {
            addExpenseTypes[lastSelectedIndexPath.row].isSelected = false
        }
        DispatchQueue.main.async {
            self.collectionView.reloadData()
            self.lastSelectedIndexPath = self.lastSelectedIndexPath == indexPath ? nil : indexPath
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: 150, height: 150)
    }
}
