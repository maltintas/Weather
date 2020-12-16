//
//  HourlyViewModel.swift
//  Weather
//
//  Created by Mehmet on 16.12.2020.
//  Copyright © 2020 Mehmet. All rights reserved.
//

import Foundation
import UIKit

class HourlyViewModel {
    
    var hourlyWeatherData: HourlyWeatherData
    let dayFormats = DateFormats()
    let configureIcons = ConfigureIcons()
    
    init(hourlyWeatherData: HourlyWeatherData) {
        self.hourlyWeatherData = hourlyWeatherData
    }
    
    var timeText: String {
        guard let timeText = hourlyWeatherData.time else { return "_"}
        return dayFormats.getDayFromDate(date: Date(timeIntervalSince1970: Double(timeText)), dateFormat: .Hour)
    }
    
    var iconImageText: String {
        guard let iconName = hourlyWeatherData.icon else { return "_"}
        return configureIcons.setIcons(iconName: iconName)
    }
    
    var iconImageTintColor: UIColor {
        guard let iconName = hourlyWeatherData.icon else { return .systemYellow}
        return configureIcons.configureTintColor(iconName: iconName)
    }
    
    var tempText: String {
        guard let currentTemp = hourlyWeatherData.temperature else {return "_"}
        return "\(Int(currentTemp))º"
    }
    
    func configureHourlyCollectionViewCell(cell: HourlyCollectionViewCell){
        cell.hourLabel.text = timeText
        cell.iconImage.image = UIImage(systemName: iconImageText)
        cell.iconImage.tintColor = iconImageTintColor
        cell.tempLabel.text = tempText
    }
    
}
