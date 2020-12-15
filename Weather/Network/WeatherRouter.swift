//
//  WeatherRouter.swift
//  Weather
//
//  Created by Mehmet on 15.12.2020.
//  Copyright © 2020 Mehmet. All rights reserved.
//

import Foundation
import Alamofire

enum WeatherRouter: URLRequestConvertible {
    //MARK: - URL
    static let baseURL = NetworkConstant.baseURL+NetworkConstant.apiKey
    
    case getWeather
    case getWeatherWithParameters(latitude: String, longitude: String, lang: String, units: String)
    
    //MARK: - Method
    var method: HTTPMethod {
        switch self {
        case .getWeather, .getWeatherWithParameters:
            return .get
        }
    }
    
    //MARK: - Path
    var path: String {
        switch self {
        case .getWeatherWithParameters(latitude: let latitude, longitude: let longitude, lang: _, units: _):
            return "/\(latitude),\(longitude)"
        default:
            return ""
        }
    }
    
    //MARK: - Parameters
    var parameters: [String: Any]{
        switch self {
        case .getWeatherWithParameters(latitude: _, longitude: _, lang: let lang, units: let units):
            return ["lang": lang, "units": units]
        default:
            return [:]
        }
    }
    
    //MARK: - URLRequest
    func asURLRequest() throws -> URLRequest {
        let url = try WeatherRouter.baseURL.asURL()
        var request = URLRequest(url: url.appendingPathComponent(path))
        request.httpMethod = method.rawValue
        
        request.timeoutInterval = 20
        return try URLEncoding.default.encode(request, with: parameters)
    }
    
}
