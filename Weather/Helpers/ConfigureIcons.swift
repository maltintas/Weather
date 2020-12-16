//
//  ConfigureIcons.swift
//  Weather
//
//  Created by Mehmet on 15.12.2020.
//  Copyright © 2020 Mehmet. All rights reserved.
//

import Foundation
import UIKit

struct ConfigureIcons {
    func setIcons(iconName: String) -> String {
        switch iconName {
        case "clear-day":
            return "sun.max.fill"
        case "clear-night":
            return "moon.stars"
        case "cloudy":
            return "cloud.fill"
        case "fog":
            return "cloud.fog.fill"
        case "partly-cloudy-day":
            return "cloud.sun.fill"
        case "partly-cloudy-night":
            return "cloud.moon.fill"
        case "rain":
            return "cloud.rain.fill"
        case "sleet":
            return "cloud.sleet.fill"
        case "snow":
            return "cloud.snow"
        case "thunderstorm":
            return "cloud.bolt.rain"
        case "wind":
             return "wind"
        case "hail":
            return "cloud.hail.fill"
        default:
            return "wifi.exclamationmark"
        }
    }
    
    func configureTintColor(iconName: String) -> UIColor {
           switch iconName {
           case "clear-day", "partly-cloudy-day":
               return .systemYellow
           case "clear-night", "partly-cloudy-night":
               return .parliementBlue()
           case "cloudy", "rain":
               return .systemBlue
           case "fog":
               return .opaqueSeparator
           case "sleet", "snow", "wind":
               return .tertiaryLabel
           case "hail":
               return .fontColor()
           default:
               return .systemYellow
           }
       }
}
