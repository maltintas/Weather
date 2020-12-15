//
//  Daily.swift
//  Weather
//
//  Created by Mehmet on 15.12.2020.
//  Copyright © 2020 Mehmet. All rights reserved.
//

import Foundation
struct Daily: Codable {
    let summary: String?
    let icon: String?
    let dailyData: [DailyWeatherData]?
    
    enum CodingKeys: String, CodingKey {
        case summary
        case icon
        case dailyData = "data"
    }
}
