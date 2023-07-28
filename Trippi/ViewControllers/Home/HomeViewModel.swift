//
//  HomeViewModel.swift
//  Trippi
//
//  Created by Aman Raghuvanshi on 21/07/23.
//

import UIKit
import CoreLocation

protocol HomeViewModelDelegate: AnyObject {
    func currentLocation(location: String, status: CLAuthorizationStatus)
    func showAlert()
}

class HomeViewModel: NSObject {
    
    let locationManager = CLLocationManager()
    var location = (0.0, 0.0)
    weak var delegate: HomeViewModelDelegate?
    
    override init () {
        super.init()
        locationManager.delegate = self
        locationManager.requestLocation()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.requestLocation()
    }
    
    func getCurrentLocation() {
        DispatchQueue.main.async {
            switch self.locationManager.authorizationStatus {
            case .authorizedWhenInUse, .authorizedAlways:
                if let currentLocation:CLLocation = self.locationManager.location {
                    self.location.0 = currentLocation.coordinate.latitude
                    self.location.1 = currentLocation.coordinate.longitude
                    self.getReversedGeoLocation(location: currentLocation)
                }
            case .denied, .restricted:
                self.delegate?.showAlert()
            default:
                self.locationManager.requestLocation()
            }
        }
    }
    
    func getReversedGeoLocation(location : CLLocation) {
        CLGeocoder().reverseGeocodeLocation(location) {
            placemarks , error in
            if error == nil && placemarks!.count > 0 {
                guard let placemark = placemarks?.last else {
                    return
                }
                let reversedGeoLocation = ReversedGeoLocation(with: placemark)
                self.delegate?.currentLocation(location: reversedGeoLocation.city, status: self.locationManager.authorizationStatus)
            }
        }
    }
}

extension HomeViewModel: CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        location.0 = locValue.latitude
        location.1 = locValue.longitude
        getReversedGeoLocation(location: CLLocation(latitude: locValue.latitude, longitude: locValue.longitude))
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
    }
}
