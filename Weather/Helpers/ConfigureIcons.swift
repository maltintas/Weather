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
    func setIcons(iconName: String) -> UIImage {
        switch iconName {
        case "clear-day":
            return UIImage(systemName: "sun.max.fill") ?? UIImage(systemName: "wifi.exclamationmark")!
        case "clear-night":
            return UIImage(systemName: "sun.max.fill") ?? UIImage(systemName: "wifi.exclamationmark")!
        case "cloudy":
            return UIImage(systemName: "cloud.fill") ?? UIImage(systemName: "wifi.exclamationmark")!
        case "fog":
            return UIImage(systemName: "cloud.fill") ?? UIImage(systemName: "wifi.exclamationmark")!
        case "partly-cloudy-day":
            return UIImage(systemName: "cloud.sun.fill") ?? UIImage(systemName: "wifi.exclamationmark")!
        case "partly-cloudy-night":
            return UIImage(systemName: "cloud.moon.fill") ?? UIImage(systemName: "wifi.exclamationmark")!
        case "rain":
            return UIImage(systemName: "cloud.rain.fill") ?? UIImage(systemName: "wifi.exclamationmark")!
        case "sleet":
            return UIImage(systemName: "cloud.sleet.fill") ?? UIImage(systemName: "wifi.exclamationmark")!
        case "snow":
            return UIImage(systemName: "cloud.snow") ?? UIImage(systemName: "wifi.exclamationmark")!
        case "thunderstorm":
            return UIImage(systemName: "cloud.bolt.rain") ?? UIImage(systemName: "wifi.exclamationmark")!
        case "wind":
             return UIImage(systemName: "wind") ?? UIImage(systemName: "wifi.exclamationmark")!
        default:
            return UIImage(systemName: "wifi.exclamationmark")!
        }
    }
}
