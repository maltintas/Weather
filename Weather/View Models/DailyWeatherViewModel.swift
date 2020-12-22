//
//  DailyWeatherViewModel.swift
//  Weather
//
//  Created by Mehmet on 20.12.2020.
//  Copyright © 2020 Mehmet. All rights reserved.
//

import Foundation
import UIKit

class DailyWeatherViewModel {
    
    var dailyWeatherData: DailyWeatherData
    let dateFormats = DateFormats()
    let configureIcons = ConfigureIcons()
    
    
    init(dailyWeatherData: DailyWeatherData) {
        self.dailyWeatherData = dailyWeatherData
    }
    
    var dayText: String {
        return dateFormats.getDayFromDate(date: Date(timeIntervalSince1970: Double(dailyWeatherData.time ?? 0)), dateFormat: .days)
    }
    
    var iconImageName: String {
        guard let iconName = dailyWeatherData.icon else { return "_"}
        return configureIcons.setIcons(iconName: iconName)
    }
    
    var iconImageTintColor: UIColor {
        guard let iconName = dailyWeatherData.icon else { return .systemYellow}
        return configureIcons.configureTintColor(iconName: iconName)
    }
    
    var maxTempText: String {
        return "\(Int(dailyWeatherData.temperatureMax ?? 0))"
    }
    
    var minTempText: String {
        return "\(Int(dailyWeatherData.temperatureMin ?? 0))"
    }
}

extension DailyWeatherViewModel {
    
    func configure(cell: DaysTableViewCell){
        cell.dayLabel.text = dayText
        cell.iconImage.image = UIImage(systemName: iconImageName)
        cell.iconImage.tintColor = iconImageTintColor
        cell.maxTempLabel.text = maxTempText
        cell.minTempLabel.text = minTempText
    }
}
