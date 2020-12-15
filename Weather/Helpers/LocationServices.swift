//
//  LocationServices.swift
//  Weather
//
//  Created by Mehmet on 15.12.2020.
//  Copyright © 2020 Mehmet. All rights reserved.
//

import Foundation
import MapKit

class LocationServices {
    
    //MARK: - Properties
    let fireAlertMessage = AlertMessage()
    let mainVC: MainViewController
    
    init(mainViewController: MainViewController) {
        self.mainVC = mainViewController
    }
    
    func checkLocationServices(locationManager: CLLocationManager, delegate: CLLocationManagerDelegate){
        guard CLLocationManager.locationServicesEnabled() else {
            fireAlertMessage.alertMessage(message: "Please check your location services.", viewController: mainVC)
            return
        }
        
        locationManager.distanceFilter = 1000
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        checkAuthorizationForLocation(locationManager: locationManager)
    }
    
    //LocationService Permissions
    func checkAuthorizationForLocation(locationManager: CLLocationManager) {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedAlways, .authorizedWhenInUse:
            locationManager.startUpdatingLocation()
            break
            
        case .denied:
            fireAlertMessage.alertMessage(message: "Please turn on location services.", viewController: mainVC)
            break
            
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            
        case .restricted:
            fireAlertMessage.alertMessage(message: "Please turn on location services.", viewController: mainVC)
            break
        @unknown default:
            break
        }
    }
}
