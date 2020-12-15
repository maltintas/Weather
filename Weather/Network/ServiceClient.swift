//
//  ServiceClient.swift
//  Weather
//
//  Created by Mehmet on 15.12.2020.
//  Copyright © 2020 Mehmet. All rights reserved.
//

import Foundation
import Alamofire

class ServiceClient {
    static func makeRequest<T: Codable>(route: URLRequestConvertible, codableType: T.Type, completion: @escaping (_ response: T?, _ error: Error?) -> Void){
        AF.request(route).validate().responseDecodable(of: T.self) { (response) in
            completion(response.value, response.error)
        }
    }
}
