//
//  DateFormats.swift
//  Weather
//
//  Created by Mehmet on 15.12.2020.
//  Copyright © 2020 Mehmet. All rights reserved.
//

import Foundation

class DateFormats {
    enum DateFormat {
        case HourAndMinute, days, Hour
        var format: String {
            switch self {
            case .HourAndMinute:
                return "HH:mm"
            case .days:
                return "EEEE"
            case .Hour:
                return "HH"
            }
        }
    }
    
    func getDayFromDate(date: Date?, dateFormat: DateFormat) -> String {
        guard let date = date else {
            return ""
        }
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormat.format
        return formatter.string(from: date)
    }
}



