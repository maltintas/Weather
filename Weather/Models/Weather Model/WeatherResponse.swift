//
//  WeatherResponse.swift
//  Weather
//
//  Created by Mehmet on 15.12.2020.
//  Copyright © 2020 Mehmet. All rights reserved.
//

import Foundation
struct WeatherResponse: Codable {
    let latitude: Double?
    let longitude: Double?
    var timezone: String?
    let currently: Currently?
    let hourly: Hourly?
    let daily: Daily?

    enum CodingKeys: CodingKey {
        case latitude
        case longitude
        case timezone
        case currently
        case hourly
        case daily
    }
}
