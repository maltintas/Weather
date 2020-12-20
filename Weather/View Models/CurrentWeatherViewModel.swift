//
//  CurrentWeatherViewModel.swift
//  Weather
//
//  Created by Mehmet on 15.12.2020.
//  Copyright © 2020 Mehmet. All rights reserved.
//

import Foundation
import UIKit

class CurrentWeatherViewModel {
    
    let currentWeatherData: Currently
    let dailyWeatherData: DailyWeatherData
    let dayFormats = DateFormats()
    let configureIcon = ConfigureIcons()
    var city: City?
    
    init(currentWeatherData: Currently, dailyWeatherData: DailyWeatherData, city: City?) {
        self.currentWeatherData = currentWeatherData
        self.dailyWeatherData = dailyWeatherData
        self.city = city
    }
    
    var currentLocatinText: String {
        //Beşiktaş is the default coordinate city defined in MainVC/getWheatherData()
        return city?.name ?? "Beşiktaş"
    }
    
    var currentTempText: String {
        guard let temp = currentWeatherData.temperature else { return "_"}
        return "\(Int(temp))"
    }
    
    var maxMinTempText: String {
        guard let maxTemp = dailyWeatherData.temperatureMax else { return "_"}
        guard let minTemp = dailyWeatherData.temperatureMin else { return "_"}
        return "\(Int(maxTemp))℃ | \(Int(minTemp))℃"
    }
    
    var summaryText: String {
        guard let summary = currentWeatherData.summary else { return "_"}
        return "\(summary)"
    }
    
    var sunRiseTimeText: String {
        guard let sunRiseTime = dailyWeatherData.sunriseTime else { return "_"}
        return dayFormats.getDayFromDate(date: Date(timeIntervalSince1970: Double(sunRiseTime)), dateFormat: .HourAndMinute)
    }
    
    var windSpeedText: String {
        guard let windSpeed = dailyWeatherData.windSpeed else {return "_"}
        return "\(Int(windSpeed)) km/s"
    }
    
    var precipProbilityICon: String {
        guard let precipType = dailyWeatherData.precipType else {return "sun.min.fill"}
        return configureIcon.setIcons(iconName: precipType)
    }
    
    var precipProbabilityText: String {
        guard let precipProbability = dailyWeatherData.precipProbability else { return "_"}
        return "%\(Int(precipProbability * 100))"
    }
    
    var iconImageText: String {
        guard let iconName = currentWeatherData.icon else {return "_"}
        return configureIcon.setIcons(iconName: iconName)
    }
    
    var iconImageTintColor: UIColor {
        guard let iconName = currentWeatherData.icon else {return .systemYellow}
        return configureIcon.configureTintColor(iconName: iconName)
    }
    
   
    
    func configureTopUIElements(mainVC: MainViewController){
        mainVC.locationLabel.text = currentLocatinText
        mainVC.maxMinTempLabel.text = maxMinTempText

    }
    
    func configureMidUIElements(currentView: CurrentView){
        currentView.currentWeatherImageview.image = UIImage(systemName: iconImageText)
        currentView.currentWeatherImageview.tintColor = iconImageTintColor
        currentView.currentTempLabel.text = currentTempText
        currentView.summaryLabel.text = summaryText
        currentView.sunRiseTimeLabel.text = sunRiseTimeText
        currentView.windSpeedLabel.text = windSpeedText
        currentView.precipIcon.image = UIImage(systemName: precipProbilityICon)
        currentView.precipProbability.text = precipProbabilityText
    }
    
}
