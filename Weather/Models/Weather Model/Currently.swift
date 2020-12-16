//
//  Currently.swift
//  Weather
//
//  Created by Mehmet on 15.12.2020.
//  Copyright © 2020 Mehmet. All rights reserved.
//

import Foundation
struct Currently: Codable {
    let time: Int?
    let summary: String?
    let icon: String?
    let precipIntensity: Double?
    let precipProbability: Double?
    let temperature: Double?
    let apparentTemprature: Double?
    let windSpeed: Double?
    
    enum CodingKeys: CodingKey {
        case time
        case summary
        case icon
        case precipIntensity
        case precipProbability
        case temperature
        case apparentTemprature
        case windSpeed
    }
}
