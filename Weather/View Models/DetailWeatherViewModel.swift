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
    
    func configure(cell: DetailTableViewCell, indexPath: IndexPath){
        
        guard let sunSetTime = dailyWeatherData.sunsetTime else {return}
        guard let dewPoint = dailyWeatherData.dewPoint else {return}
        guard let humidity = dailyWeatherData.humidity else {return}
        guard let pressure = dailyWeatherData.pressure else {return}
        guard let visibility = dailyWeatherData.visibility else {return}
        guard let uvIndex = dailyWeatherData.uvIndex else {return}
        guard let tempHighTime = dailyWeatherData.temperatureHighTime else {return}
        guard let tempLowTime = dailyWeatherData.temperatureLowTime else {return}
        guard let precipIntensity = dailyWeatherData.precipIntensity else {return}
        
        switch indexPath.row {
        case 0:
            cell.iconImage.image = UIImage(systemName: "sunset.fill")
            cell.iconImage.tintColor = .systemYellow
            cell.detailLabel.text = dateFormats.getDayFromDate(date: Date(timeIntervalSince1970: Double(sunSetTime)), dateFormat: .HourAndMinute)
        case 1:
            cell.iconImage.image = UIImage(systemName: "drop.triangle")
            cell.iconImage.tintColor = .systemBlue
            cell.detailLabel.text = "\(Int(dewPoint))º"
        case 2:
            cell.iconImage.image = UIImage(systemName: "barometer")
            cell.iconImage.tintColor = .brown
            cell.detailLabel.text = "\(Int(pressure)) ㍱"
        case 3:
            cell.iconImage.image = UIImage(systemName: "drop.fill")
            cell.iconImage.tintColor = .systemBlue
            cell.detailLabel.text = "% \(Int(humidity * 100))"
        case 4:
            cell.iconImage.image = UIImage(systemName: "sun.haze.fill")
            cell.iconImage.tintColor = .systemGray5
            cell.detailLabel.text = "\(visibility)m"
        case 5:
            cell.iconImage.image = UIImage(systemName: "sun.dust.fill")
            cell.iconImage.tintColor = .systemOrange
            cell.detailLabel.text = "UV: \(uvIndex)"
        case 6:
            cell.iconImage.image = UIImage(systemName: "thermometer.sun.fill")
            cell.iconImage.tintColor = .systemRed
            cell.detailLabel.text = dateFormats.getDayFromDate(date: Date(timeIntervalSince1970: Double(tempHighTime)), dateFormat: .HourAndMinute)
        case 7:
            cell.iconImage.image = UIImage(systemName: "thermometer.snowflake")
            cell.iconImage.tintColor = .systemBlue
            cell.detailLabel.text = dateFormats.getDayFromDate(date: Date(timeIntervalSince1970: Double(tempLowTime)), dateFormat: .HourAndMinute)
        case 8:
            cell.iconImage.image = UIImage(systemName: "umbrella")
            cell.iconImage.tintColor = .systemPurple
            cell.detailLabel.text = "\(precipIntensity)"
        case 9:
            cell.iconImage.image = UIImage(systemName: "drop.fill")
            cell.iconImage.tintColor = .black
            cell.detailLabel.text = "Powered by Dark Sky"
        default:
            cell.iconImage.image = UIImage(systemName: "exclamationmark.triangle.fill")
            cell.detailLabel.text = "Something goes wrong"
        }
    }
}

