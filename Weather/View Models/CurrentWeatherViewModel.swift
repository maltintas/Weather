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
    
    init(currentWeatherData: Currently, dailyWeatherData: DailyWeatherData) {
        self.currentWeatherData = currentWeatherData
        self.dailyWeatherData = dailyWeatherData
    }
    
    var currentTempText: String {
        return "\(String(describing: Int(self.currentWeatherData.temperature ?? 0)))"
    }
    
    var maxMinTempText: String {
        return "\(Int(self.dailyWeatherData.temperatureMax ?? 0))℃ | \(Int(self.dailyWeatherData.temperatureMin ?? 0))℃"
    }
    
    var summaryText: String {
        return "\(String(describing: self.currentWeatherData.summary))"
    }
    
    var sunRiseTimeText: String {
        return dayFormats.getDayFromDate(date: Date(timeIntervalSince1970: Double(dailyWeatherData.sunriseTime ?? 0)), dateFormat: .HourAndMinute)
    }
    
    var windSpeedText: String {
        return "\(String(describing: dailyWeatherData.windSpeed))km/s"
    }
    
    var apparentTempText: String {
        return "\(Int(dailyWeatherData.apparentTemprature ?? 0))"
    }
    
    var iconImageText: String {
        return "\(String(describing: dailyWeatherData.icon))"
    }
}
