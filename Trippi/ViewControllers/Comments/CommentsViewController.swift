//
//  CommentsViewController.swift
//  Trippi
//
//  Created by macmini50 on 08/08/23.
//

import UIKit

class CommentsViewController: UIViewController {

    var isKeyboardVisible = true
    
    
    let defaultHeight: CGFloat = UIScreen.main.bounds.height / 2 //400
    let dismissibleHeight: CGFloat = (UIScreen.main.bounds.height * 40) / 100//200
    let maximumContainerHeight: CGFloat = UIScreen.main.bounds.height - 150
    var currentContainerHeight: CGFloat = UIScreen.main.bounds.height / 2
    
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
        
        setupPanGesture()
        setUpUI()
        
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
