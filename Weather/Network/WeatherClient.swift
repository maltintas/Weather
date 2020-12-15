//
//  WeatherClient.swift
//  Weather
//
//  Created by Mehmet on 15.12.2020.
//  Copyright © 2020 Mehmet. All rights reserved.
//

import Foundation
import Alamofire

class WeatherClient: ServiceClient {
    public static func getWeather(latitude: String, longitude: String, completion: @escaping (_ response: WeatherResponse?, _ error: Error?) -> Void){
        makeRequest(route: WeatherRouter.getWeatherWithParameters(latitude: latitude, longitude: longitude, lang: "en", units: "auto"), codableType: WeatherResponse.self, completion: completion)
    }
}
