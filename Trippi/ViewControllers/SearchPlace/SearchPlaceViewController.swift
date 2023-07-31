//
//  SearchPlaceViewController.swift
//  Trippi
//
//  Created by Aman Raghuvanshi on 31/07/23.
//

import UIKit

class SearchPlaceViewController: UIViewController {
    static let identifier = "SearchPlaceViewController"

    @IBOutlet weak var searchTextFieldContainerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchTextFieldContainerView.layer.cornerRadius = 15
    }
    
    @IBAction func onClickCross(_ sender: Any) {
        self.dismiss(animated: true)
    }
}
