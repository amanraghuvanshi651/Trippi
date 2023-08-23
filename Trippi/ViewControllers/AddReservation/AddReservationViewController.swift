//
//  AddReservationViewController.swift
//  Trippi
//
//  Created by Aman Raghuvanshi on 22/08/23.
//

import UIKit
import Fastis
import MobileCoreServices
import UniformTypeIdentifiers

class AddReservationViewController: UIViewController, UITextFieldDelegate {
    var selectedReservationType: TripReservationType = .train
    var reservation = TripReservation(id: "", reservationType: .train, fromPlace: "", toPlace: "", date: Date())
    var dateFormatter = DateFormatter()
    var selectedDate = Date()
    
    
    //MARK: Outlets
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var fromTextField: UITextField!
    @IBOutlet weak var toTextField: UITextField!
    @IBOutlet weak var dateButton: UIButton!
    @IBOutlet weak var attachmentButton: UIButton!
    @IBOutlet weak var addButton: UIButton!
    
    //Resetvation Type
    @IBOutlet weak var trainButton: UIButton!
    @IBOutlet weak var trainLabel: UILabel!
    @IBOutlet weak var flightButton: UIButton!
    @IBOutlet weak var flightLabel: UILabel!
    @IBOutlet weak var busButton: UIButton!
    @IBOutlet weak var busLabel: UILabel!
    
    //preview
    @IBOutlet weak var previewContainerView: UIView!
    @IBOutlet weak var dottedContainerView: UIView!
    @IBOutlet weak var travelModeImageView: UIImageView!
    @IBOutlet weak var travelModeLabel: UILabel!
    @IBOutlet weak var fullCityFromLabel: UILabel!
    @IBOutlet weak var halfCityFromLabel: UILabel!
    @IBOutlet weak var fullCityToLabel: UILabel!
    @IBOutlet weak var halfCityToLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        fromTextField.delegate = self
        toTextField.delegate = self
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapBackground))
        self.view.addGestureRecognizer(tap)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
    
    //MARK: Actions
    @IBAction func onClickBackgroundView(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func onClickTrainButton(_ sender: Any) {
        selectedReservationType = .train
        reservation.reservationType = selectedReservationType
        setUpReservationTypeUI(type: selectedReservationType)
    }
    
    @IBAction func onClickFlightButton(_ sender: Any) {
        selectedReservationType = .flight
        reservation.reservationType = selectedReservationType
        setUpReservationTypeUI(type: selectedReservationType)
    }
    
    @IBAction func onClickBusButton(_ sender: Any) {
        selectedReservationType = .bus
        reservation.reservationType = selectedReservationType
        setUpReservationTypeUI(type: selectedReservationType)
    }
    
    @IBAction func onClickDateButton(_ sender: Any) {
        var customConfig = FastisConfig.default
        customConfig.controller.barButtonItemsColor = .black
        customConfig.dayCell.selectedBackgroundColor = UIColor(named: BUTTON_BACKGROUND_COLOR)!
        customConfig.dayCell.onRangeBackgroundColor = UIColor(named: BUTTON_BACKGROUND_TRANSPARENT)!
        
        let fastisController = FastisController(mode: .single, config: customConfig)
        fastisController.title = ""
        fastisController.minimumDate = Date()
        fastisController.allowToChooseNilDate = false
        
        fastisController.doneHandler = { [weak self] resultRange in
            guard let self = self else { return }
            selectedDate = resultRange ?? Date()
            setUpDateButton(start: selectedDate)
        }
        fastisController.present(above: self)
    }
    
    @IBAction func onClickAttachmentButton(_ sender: Any) {
        selectFiles()
    }
    
    @IBAction func onClickAddButton(_ sender: Any) {
    }
    
    //Custom Methods
    @objc func didTapBackground() {
        self.view.endEditing(true)
    }
    
    func setUpUI() {
        containerView.layer.cornerRadius = 10
        dateButton.layer.cornerRadius = 10
        attachmentButton.layer.cornerRadius = 10
        previewContainerView.layer.cornerRadius = 10
        addButton.layer.cornerRadius = 10
        
        dottedContainerView.drawDottedLine()
    }
    
    func setUpDateButton(start: Date) {
        dateFormatter.dateFormat = "d MMM yyyy"
        let startDateString = dateFormatter.string(from: start)
        
        dateButton.setTitle(startDateString, for: .normal)
    }
    
    func setUpReservationTypeUI(type: TripReservationType) {
        travelModeImageView.image = UIImage(named: type.rawValue)
        travelModeLabel.text = type.rawValue
        switch type {
        case .flight:
            flightButton.tintColor = UIColor(named: TEXT_COLOR)
            flightLabel.textColor = UIColor(named: TEXT_COLOR)
            
            trainButton.tintColor = UIColor(named: SECONDARY_TEXT_COLOR)
            trainLabel.textColor = UIColor(named: SECONDARY_TEXT_COLOR)
            busButton.tintColor = UIColor(named: SECONDARY_TEXT_COLOR)
            busLabel.textColor = UIColor(named: SECONDARY_TEXT_COLOR)
        case .train:
            trainButton.tintColor = UIColor(named: TEXT_COLOR)
            trainLabel.textColor = UIColor(named: TEXT_COLOR)
            
            flightButton.tintColor = UIColor(named: SECONDARY_TEXT_COLOR)
            flightLabel.textColor = UIColor(named: SECONDARY_TEXT_COLOR)
            busButton.tintColor = UIColor(named: SECONDARY_TEXT_COLOR)
            busLabel.textColor = UIColor(named: SECONDARY_TEXT_COLOR)
        case .bus:
            busButton.tintColor = UIColor(named: TEXT_COLOR)
            busLabel.textColor = UIColor(named: TEXT_COLOR)
            
            trainButton.tintColor = UIColor(named: SECONDARY_TEXT_COLOR)
            trainLabel.textColor = UIColor(named: SECONDARY_TEXT_COLOR)
            flightButton.tintColor = UIColor(named: SECONDARY_TEXT_COLOR)
            flightLabel.textColor = UIColor(named: SECONDARY_TEXT_COLOR)
        }
    }
    
    func setUpPreviewView() {
        reservation.fromPlace = fromTextField.text ?? ""
        reservation.toPlace = toTextField.text ?? ""
        reservation.date = Date()
    }
    
    func selectFiles() {
        let types = UTType.types(tag: "pdf",
                                 tagClass: UTTagClass.filenameExtension,
                                 conformingTo: nil)
        let documentPickerController = UIDocumentPickerViewController(
                forOpeningContentTypes: types)
        documentPickerController.delegate = self
        self.present(documentPickerController, animated: true, completion: nil)
    }
}

//MARK: Document Picker Delegate
extension AddReservationViewController: UIDocumentPickerDelegate {
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
    }
}
