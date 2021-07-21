//
//  LocationManager.swift
//  WeatherApp
//
//  Created by Dev on 2021-07-19.
//

import Foundation
import CoreLocation

protocol LocationAutorizationDelegate {
    func tracingAuthorization()
    func updateLocationName()
    func errorWith(message: String)
}


class LocationService: NSObject {
    static let sharedInstance: LocationService = {
        let instance = LocationService()
        return instance
    }()
    
    private lazy var locationManager = CLLocationManager()
    private lazy var currentLocation = CLLocation()
    private lazy var currentLocationName: String = ""
    var locationDelegate: LocationAutorizationDelegate?

    override init() {
        super.init()
        self.locationManager.delegate = self
    }
    
    func requestAlwaysAuthorization() {
        locationManager.requestAlwaysAuthorization()
    }
    
    func requestLowAccuracy() {
        locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
        locationManager.distanceFilter = 100
    }
    
    func startUpdatingLocation() {
        locationManager.startUpdatingLocation()
    }
    
    func stopUpdatingLocation() {
        locationManager.stopUpdatingLocation()
    }
    
    func isLocationServiceEnabled() -> Bool {
        if CLLocationManager.locationServicesEnabled() {
            switch(CLLocationManager.authorizationStatus()) {
            case .notDetermined:
                self.requestAlwaysAuthorization()
                return true
            case .restricted, .denied :
                return false
            default:
                return true
            }
        } else {
            return false
        }
    }
    
    func getCurrentLocationName() -> String {
        return currentLocationName
    }
}

extension LocationService: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else {
            return
        }
         if location.horizontalAccuracy < 0 {
             return
         }
        
        if location.horizontalAccuracy > currentLocation.horizontalAccuracy {
            self.currentLocation = location
            stopUpdatingLocation()
            let geocoder = CLGeocoder()
            geocoder.reverseGeocodeLocation(currentLocation, completionHandler: { (placemarks, error) in
                if let error = error {
                    self.locationDelegate?.errorWith(message: error.localizedDescription)
                } else if let placemark = placemarks, !placemark.isEmpty {
                    self.currentLocationName = placemark.first?.locality ?? ""
                    debugPrint(self.currentLocationName)
                    self.locationDelegate?.updateLocationName()
                } else {
                    self.locationDelegate?.errorWith(message: Message.notGetinglocation.localized)
                }
            })
         }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error){
        debugPrint(error.localizedDescription)
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        locationDelegate?.tracingAuthorization()
    }
}
