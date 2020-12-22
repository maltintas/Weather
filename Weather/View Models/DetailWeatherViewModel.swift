//
//  DetailWeatherViewModel.swift
//  Weather
//
//  Created by Mehmet on 20.12.2020.
//  Copyright © 2020 Mehmet. All rights reserved.
//

import Foundation
import UIKit

class DetailWeatherViewModel {
    
    var dailyWeatherData: DailyWeatherData
    let dateFormats = DateFormats()
    
    init(dailyWeatherData: DailyWeatherData) {
        self.dailyWeatherData = dailyWeatherData
    }
    
    
    var sunSetText: String {
         guard let sunSetTime = dailyWeatherData.sunsetTime else {return "_"}
         return dateFormats.getDayFromDate(date: Date(timeIntervalSince1970: Double(sunSetTime)), dateFormat: .HourAndMinute)
    }
    
    var dewPoint: String {
         guard let dewPoint = dailyWeatherData.dewPoint else {return "_"}
        return "\(Int(dewPoint))℃"
    }
    
    var pressure: String {
        guard let pressure = dailyWeatherData.pressure else {return "_"}
        return "\(Int(pressure)) ㍱"
    }
    
    var humidity: String {
         guard let humidity = dailyWeatherData.humidity else {return "_"}
        return "% \(Int(humidity * 100))"
    }
    
    var visibility: String {
        guard let visibility = dailyWeatherData.visibility else {return "_"}
        return "\(visibility)m"
    }
    
    var uvIndex: String {
         guard let uvIndex = dailyWeatherData.uvIndex else {return "_"}
        return "\(uvIndex)"
    }
    
    var tempHighTime: String {
        guard let tempHighTime = dailyWeatherData.temperatureHighTime else {return "_"}
        return dateFormats.getDayFromDate(date: Date(timeIntervalSince1970: Double(tempHighTime)), dateFormat: .HourAndMinute)
    }
    
    var tempLowTime: String {
        guard let tempLowTime = dailyWeatherData.temperatureLowTime else {return "_"}
        return dateFormats.getDayFromDate(date: Date(timeIntervalSince1970: Double(tempLowTime)), dateFormat: .HourAndMinute)
    }
    
    func configureDetailView(detailView: DetailUIView) {
        detailView.sunSetTimeLabel.text = sunSetText
        detailView.dewPointLabel.text = dewPoint
        detailView.pressureLabel.text = pressure
        detailView.humidityLabel.text = humidity
        detailView.visibilityLabel.text = visibility
        detailView.uvIndexLabel.text = uvIndex
        detailView.TempHighLabel.text = tempHighTime
        detailView.tempLowLabel.text = tempLowTime
    }
}

