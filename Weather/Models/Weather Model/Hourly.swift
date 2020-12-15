//
//  Hourly.swift
//  Weather
//
//  Created by Mehmet on 15.12.2020.
//  Copyright © 2020 Mehmet. All rights reserved.
//

import Foundation
struct Hourly: Codable {
    let summary: String?
    let icon: String?
    let hourlyData: [HourlyWeatherData]?
    
    enum CodingKeys: String, CodingKey {
        case summary
        case icon
        case hourlyData = "data"
    }
}
