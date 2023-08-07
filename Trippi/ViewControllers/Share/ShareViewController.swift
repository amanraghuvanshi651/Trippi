//
//  ShareViewController.swift
//  Trippi
//
//  Created by macmini50 on 07/08/23.
//

import UIKit

class ShareViewController: UIViewController {
    
    var users = [
        ShareUserModel(username: "teddy_yo", pic: "User", isSelected: false),
        ShareUserModel(username: "spy.me", pic: "User", isSelected: false),
        ShareUserModel(username: "angry.guy", pic: "User", isSelected: false),
        ShareUserModel(username: "sam.the.boi", pic: "User", isSelected: false),
        ShareUserModel(username: "someone.in.the.game", pic: "User", isSelected: false),
        ShareUserModel(username: "theridingboots", pic: "User", isSelected: false),
        ShareUserModel(username: "teddy_yo", pic: "User", isSelected: false),
        ShareUserModel(username: "spy.me", pic: "User", isSelected: false),
        ShareUserModel(username: "angry.guy", pic: "User", isSelected: false),
        ShareUserModel(username: "sam.the.boi", pic: "User", isSelected: false),
        ShareUserModel(username: "someone.in.the.game", pic: "User", isSelected: false),
        ShareUserModel(username: "theridingboots", pic: "User", isSelected: false)
    ]

    //MARK: - Outlets
    @IBOutlet weak var containterView: UIView!
    @IBOutlet weak var sharingOptionsContainerView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var messageTextField: UITextField!
    @IBOutlet weak var sendButton: UIButton!
    
    @IBOutlet weak var containerViewBottomConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        containterView.layer.cornerRadius = 20
        sendButton.layer.cornerRadius = 25
        
        sharingOptionsContainerView.addShadow(color: UIColor.black.cgColor, opacity: 0.3, offset: CGSize(width: 0, height: 1), radius: 5)
        
        tableView.register(UINib(nibName: ShareToUserTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: ShareToUserTableViewCell.identifier)
        collectionView.register(UINib(nibName: SharingOptionCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: SharingOptionCollectionViewCell.identifier)
        
//        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapBackGroundView))
//        view.addGestureRecognizer(tapGesture)
    }
    
    //MARK: - Actions
    @IBAction func onClickSendButton(_ sender: Any) {
    }
    
    //MARK: - Custom Methods
    @objc func keyboardWillShow(_ notification: Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            
            self.containerViewBottomConstraint.constant = keyboardHeight
        }
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        self.containerViewBottomConstraint.constant = 0
    }
    
    @objc func didTapBackGroundView() {
        view.endEditing(true)
    }
}

//MARK: - TableView Delegate and DataSource
extension ShareViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ShareToUserTableViewCell.identifier) as! ShareToUserTableViewCell
        cell.configure(shareUser: users[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        users[indexPath.row].isSelected.toggle()
        
        DispatchQueue.main.async {
            let isSelected = self.users.contains(where: { user in
                user.isSelected
            })
            
            if isSelected {
                self.sendButton.isHidden = !isSelected
                self.messageTextField.isHidden = !isSelected
            }
            
            UIView.animate(withDuration: 0.3) {
                self.sendButton.alpha = isSelected ? 1 : 0
                self.messageTextField.alpha = isSelected ? 1 : 0
            } completion: { _ in
                if !isSelected {
                    self.sendButton.isHidden = !isSelected
                    self.messageTextField.isHidden = !isSelected
                    self.didTapBackGroundView()
                }
            }
            self.tableView.reloadRows(at: [indexPath], with: .none)
        }
    }
    
}

//MARK: - CollectionView Delegate and DataSource
extension ShareViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SharingOptionCollectionViewCell.identifier, for: indexPath) as! SharingOptionCollectionViewCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 40, height: 40)
    }
}
