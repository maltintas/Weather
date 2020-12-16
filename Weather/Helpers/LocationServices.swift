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
    
    func checkLocationServices(locationManager: CLLocationManager, delegate: CLLocationManagerDelegate, viewController: UIViewController){
        guard CLLocationManager.locationServicesEnabled() else {
            fireAlertMessage.alertMessage(message: "Please check your location services.", viewController: viewController)
            return
        }
        
        locationManager.distanceFilter = 1000
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        checkAuthorizationForLocation(locationManager: locationManager, viewController: viewController)
    }
    
    //LocationService Permissions
    func checkAuthorizationForLocation(locationManager: CLLocationManager, viewController: UIViewController) {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedAlways, .authorizedWhenInUse:
            locationManager.startUpdatingLocation()
            break
            
        case .denied:
            fireAlertMessage.alertMessage(message: "Please turn on location services.", viewController: viewController)
            break
            
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            
        case .restricted:
            fireAlertMessage.alertMessage(message: "Please turn on location services.", viewController: viewController)
            break
        @unknown default:
            break
        }
    }
}
