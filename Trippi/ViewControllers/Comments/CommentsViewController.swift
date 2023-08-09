//
//  CommentsViewController.swift
//  Trippi
//
//  Created by Aman Raghuvanshi on 08/08/23.
//

import UIKit

class CommentsViewController: UIViewController {

    var isKeyboardVisible = true
    
    var comments = [
        CommentDataModel(id: "0", pic: "User", username: "aman", comment: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.", likesCount: "2", isLiked: false),
        CommentDataModel(id: "1", pic: "User", username: "abhay", comment: "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.", likesCount: "1", isLiked: false),
        CommentDataModel(id: "2", pic: "User", username: "ajay", comment: "OP", likesCount: "3", isLiked: false),
        CommentDataModel(id: "3", pic: "User", username: "sanil", comment: "GG", likesCount: "6", isLiked: false),
        CommentDataModel(id: "4", pic: "User", username: "sunil", comment: "🤪🤪", likesCount: "0", isLiked: false),
        CommentDataModel(id: "5", pic: "User", username: "yash", comment: "🥺😢😭", likesCount: "2", isLiked: false),
        CommentDataModel(id: "6", pic: "User", username: "chayan", comment: "😱😨😰😥😓🫣", likesCount: "5", isLiked: false)
    ]
    
    
    let defaultHeight: CGFloat = UIScreen.main.bounds.height / 1.3 //400
    let dismissibleHeight: CGFloat = (UIScreen.main.bounds.height * 50) / 100//200
    let maximumContainerHeight: CGFloat = UIScreen.main.bounds.height - 80
    var currentContainerHeight: CGFloat = UIScreen.main.bounds.height / 1.3
    
    //MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var commentTextField: UITextField!
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var commentSectionContainerView: UIView!
    @IBOutlet weak var backgroundButton: UIButton!
    
    @IBOutlet weak var containerViewHeightConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        containerViewHeightConstraint.constant = currentContainerHeight
        setupPanGesture()
        setUpUI()
        
        tableView.register(UINib(nibName: CommentTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: CommentTableViewCell.identifier)
        
        //setting notification observer for keyboard
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    //MARK: - Actions
    @IBAction func onClickSendButton(_ sender: Any) {
    }
    
    @IBAction func onClickBackgroundButton(_ sender: Any) {
        animateDismissView()
    }
    
    //MARK: - Custom Methods
    func setUpUI() {
        commentSectionContainerView.addShadow(color: UIColor.black.cgColor, opacity: 0.3, offset: CGSize(width: 0, height: 1), radius: 3)
        containerView.addShadow(color: UIColor.black.cgColor, opacity: 0.5, offset: CGSize(width: 0, height: 1), radius: 10)
        
        containerView.layer.cornerRadius = 20
        sendButton.layer.cornerRadius = sendButton.frame.height / 2
    }
    
    func setupPanGesture() {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture))
        panGesture.delaysTouchesBegan = false
        panGesture.delaysTouchesEnded = false
        view.addGestureRecognizer(panGesture)
    }
    
    func hideKeyboard() {
        view.endEditing(true)
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        isKeyboardVisible = true
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height - 20
            animateContainerHeight(defaultHeight)
            
            self.view.frame.origin.y -= keyboardHeight
        }
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        isKeyboardVisible = false
        self.view.frame.origin.y = 0
    }
    
    @objc func handlePanGesture(gesture: UIPanGestureRecognizer) {
        hideKeyboard()
        let translation = gesture.translation(in: view)
        let isDraggingDown = translation.y > 0
        let newHeight = currentContainerHeight - translation.y

        switch gesture.state {
        case .changed:
            if newHeight < maximumContainerHeight {
                containerViewHeightConstraint?.constant = newHeight
                view.layoutIfNeeded()
            }
        case .ended:
            if newHeight < dismissibleHeight {
                self.animateDismissView()
            }
            else if newHeight < defaultHeight {
                animateContainerHeight(defaultHeight)
            }
            else if newHeight < maximumContainerHeight && isDraggingDown {
                animateContainerHeight(defaultHeight)
            }
            else if newHeight > defaultHeight && !isDraggingDown {
                animateContainerHeight(maximumContainerHeight)
            }
        default:
            break
        }
    }
    
    func animateContainerHeight(_ height: CGFloat) {
        UIView.animate(withDuration: 0.4) {
            self.containerViewHeightConstraint?.constant = height
            self.view.layoutIfNeeded()
        }
        currentContainerHeight = height
    }
    
    func animateDismissView() {
        UIView.animate(withDuration: 0.2) {
            self.containerView.alpha = 0
            self.backgroundButton.alpha = 0
            self.containerViewHeightConstraint?.constant = 0
            self.view.layoutIfNeeded()
        } completion: { _ in
            self.dismiss(animated: true)
        }
    }
}

//MARK: - Table View Delegate and DataSource
extension CommentsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CommentTableViewCell.identifier) as! CommentTableViewCell
        cell.selectionStyle = .none
        cell.delegate = self
        cell.configure(comment: comments[indexPath.row], indexPath: indexPath)
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        hideKeyboard()
    }
}

//MARK: - comment cell delegate
extension CommentsViewController: CommentTableViewCellDelegate {
    func onClickLike(indexPath: IndexPath) {
        comments[indexPath.row].isLiked.toggle()
    }
}
