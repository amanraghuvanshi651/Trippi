//
//  HomeViewModel.swift
//  Trippi
//
//  Created by Aman Raghuvanshi on 21/07/23.
//

import UIKit
import CoreLocation

protocol HomeViewModelDelegate: AnyObject {
    func getCurrentLocation(location: String)
}

class HomeViewModel {
    
    let locationManager = CLLocationManager()
//    private let locationManager = LocationManager()
    
    init () {
        getCurrentLocation()
    }
    
    func getCurrentLocation() {
        // Ask for Authorisation from the User.
        self.locationManager.requestAlwaysAuthorization()
        
        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()
        DispatchQueue.main.async {
            if CLLocationManager.locationServicesEnabled() {
                //            locationManager.delegate = self
                self.locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
                self.locationManager.startUpdatingLocation()
                let location = self.locationManager.location?.coordinate
                let clLocation = CLLocation(latitude: location?.latitude ?? CLLocationDegrees(), longitude: location?.longitude ?? CLLocationDegrees())
                let geocoder = CLGeocoder()
                geocoder.reverseGeocodeLocation(clLocation) { placemarks, error in
                    
                    guard error == nil else {
                        print("*** Error in \(#function): \(error!.localizedDescription)")
                        return
                    }
                    
                    guard let placemark = placemarks?[0] else {
                        print("*** Error in \(#function): placemark is nil")
                        return
                    }
                    
                    print("placemark here ------------------ \(placemark)")
                }
            }
        }
    }
}
