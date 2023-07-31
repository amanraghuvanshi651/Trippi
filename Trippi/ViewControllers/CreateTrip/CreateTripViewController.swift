//
//  CreateTripViewController.swift
//  Trippi
//
//  Created by Aman Raghuvanshi on 27/07/23.
//

import UIKit
import Fastis

class CreateTripViewController: UIViewController {
    static let identifier = "CreateTripViewController"

    var dateFormatter = DateFormatter()
    
    var startDate = Date()
    var endDate = Date()
    
    //MARK: - Outlets
    @IBOutlet weak var addImageContainerView: UIView!
    @IBOutlet weak var tripImageView: UIImageView!
    @IBOutlet weak var addButton: UIButton!
    
    @IBOutlet weak var topSmallView: UIView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var saveButton: UIButton!
    
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var datePickerButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapBackGroundView))
        view.addGestureRecognizer(tapGesture)
        
        datePicker.minimumDate = Date()
        datePicker.addTarget(self, action: #selector(datePickerValueChanged(_:)), for: .valueChanged)
        datePicker.isMultipleTouchEnabled = false
        
        addImageContainerView.layer.cornerRadius = 20
        saveButton.layer.cornerRadius = 10
        datePickerButton.layer.cornerRadius = 10
        
        containerView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        containerView.layer.cornerRadius = 20
        topSmallView.layer.cornerRadius = 2.5
        
        setUpDateButton(start: startDate, end: endDate)
    }
    
    //methods
    @objc func didTapBackGroundView() {
        view.endEditing(true)
    }
    
    @objc func datePickerValueChanged(_ sender: UIDatePicker) {
        print(sender.date)
    }
    
    func setUpImageView(image: UIImage) {
        addButton.setTitle("", for: .normal)
        addButton.setImage(nil, for: .normal)
        tripImageView.image = image
    }
    
    func setUpDateButton(start: Date, end: Date) {
        dateFormatter.dateFormat = "d MMM"
        let startDateString = dateFormatter.string(from: start)
        dateFormatter.dateFormat = "d MMM yyyy"
        let endDateString = dateFormatter.string(from: end)
        
        datePickerButton.setTitle("\(startDateString) - \(endDateString)", for: .normal)
    }
    
    //MARK: - Actions
    @IBAction func onClickAddImageButton(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.delegate = self
        present(picker, animated: true)
    }
    
    @IBAction func onClickDatePickerButton(_ sender: Any) {
        var customConfig = FastisConfig.default
        customConfig.controller.barButtonItemsColor = .black
        customConfig.dayCell.selectedBackgroundColor = UIColor(named: BUTTON_BACKGROUND_COLOR)!
        customConfig.dayCell.onRangeBackgroundColor = UIColor(named: BUTTON_BACKGROUND_TRANSPARENT)!
        
        let fastisController = FastisController(mode: .range, config: customConfig)
        fastisController.title = ""
        fastisController.minimumDate = Date()
        fastisController.allowToChooseNilDate = false
        
        fastisController.doneHandler = { [weak self] resultRange in
            guard let self = self else { return }
            
            startDate = resultRange?.fromDate ?? Date()
            endDate = resultRange?.toDate ?? Date()
            
            setUpDateButton(start: startDate, end: endDate)
            
        }
        fastisController.present(above: self)
    }
    
    @IBAction func onClickSaveButton(_ sender: Any) {
        self.dismiss(animated: true)
    }
}

//MARK: - Image Picker Delegate
extension CreateTripViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        dismiss(animated: true) {
            guard let image = info[.originalImage] as? UIImage else { return }
            self.setUpImageView(image: image)
//            let imageName = UUID().uuidString
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
