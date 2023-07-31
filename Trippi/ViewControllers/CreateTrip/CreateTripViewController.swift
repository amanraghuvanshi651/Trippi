//
//  CreateTripViewController.swift
//  Trippi
//
//  Created by Aman Raghuvanshi on 27/07/23.
//

import UIKit

class CreateTripViewController: UIViewController {
    static let identifier = "CreateTripViewController"

    //MARK: - Outlets
    @IBOutlet weak var addImageContainerView: UIView!
    @IBOutlet weak var tripImageView: UIImageView!
    @IBOutlet weak var addButton: UIButton!
    
    @IBOutlet weak var topSmallView: UIView!
    @IBOutlet weak var containerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapBackGroundView))
        view.addGestureRecognizer(tapGesture)
        
        addImageContainerView.layer.cornerRadius = 20
        
        containerView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        containerView.layer.cornerRadius = 20
        topSmallView.layer.cornerRadius = 2.5
    }
    
    @objc func didTapBackGroundView() {
        view.endEditing(true)
    }
    
    func setUpImageView(image: UIImage) {
        addButton.setTitle("", for: .normal)
        addButton.setImage(nil, for: .normal)
        tripImageView.image = image
    }
    
    //MARK: - Actions
    @IBAction func onClickAddImageButton(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.delegate = self
        present(picker, animated: true)
    }
}

//MARK: - Image Picker Delegate
extension CreateTripViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        dismiss(animated: true) {
            guard let image = info[.originalImage] as? UIImage else { return }
            self.setUpImageView(image: image)
            let imageName = UUID().uuidString
//            let imagePath = getDocumentsDirectory().appendingPathComponent(imageName)
//
//            if let jpegData = image.jpegData(compressionQuality: 0.8) {
//                try? jpegData.write(to: imagePath)
//            }
        }
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
