//
//  MainViewController.swift
//  Weather
//
//  Created by Mehmet on 15.12.2020.
//  Copyright © 2020 Mehmet. All rights reserved.
//

import UIKit
import MapKit

class MainViewController: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var maxMinTempLabel: UILabel!
    @IBOutlet weak var currentWeatherImageview: UIImageView!
    @IBOutlet weak var currentTempLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var sunRiseTimeLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    @IBOutlet weak var apparentTempLabel: UILabel!
    
    //MARK: - Properties
    let fireAlertMessage = AlertMessage()
    let configureIcon = ConfigureIcons()
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        getWeatherData()
    }

    //MARK: - Network
    
    func getWeatherData(currentLocation: CLLocation = CLLocation(latitude: (41.043163), longitude: (29.007007))){
        WeatherClient.getWeather(latitude: "\(currentLocation.coordinate.latitude)", longitude: "\(currentLocation.coordinate.longitude)") { (data, error) in
            print("Get Weather Error: \(String(describing: error?.localizedDescription))")
            if error?.localizedDescription == "URLSessionTask failed with error: The Internet connection appears to be offline." {
                self.fireAlertMessage.alertMessage(message: "Please check your network connection.", viewController: self)
            }
            
            guard let currentWeather = data?.currently else { return }
            guard let firstDailyWeatherData = data?.daily?.dailyData?.first else { return }
            
            let currentWeatherViewModel = CurrentWeatherViewModel(currentWeatherData: currentWeather, dailyWeatherData: firstDailyWeatherData)
            
            self.maxMinTempLabel.text = currentWeatherViewModel.maxMinTempText
            self.currentWeatherImageview.image = self.configureIcon.setIcons(iconName: "\(currentWeatherViewModel.iconImageText)")
            self.currentTempLabel.text = currentWeatherViewModel.currentTempText
            self.summaryLabel.text = currentWeatherViewModel.summaryText
            self.sunRiseTimeLabel.text = currentWeatherViewModel.sunRiseTimeText
            self.windSpeedLabel.text = currentWeatherViewModel.windSpeedText
            self.apparentTempLabel.text = currentWeatherViewModel.apparentTempText
        }
    }

}
