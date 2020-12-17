//
//  Load.swift
//  Weather
//
//  Created by Mehmet on 17.12.2020.
//  Copyright © 2020 Mehmet. All rights reserved.
//

import Foundation
class Load {
    let documentCode = DocumentsCodes()
    var cities: [City]
    
    init(cities: [City]) {
        self.cities = cities
    }
     func cityLoad(){
        let path = documentCode.dataFilePath()
        if let data = try? Data(contentsOf: path) {
            let decoder = PropertyListDecoder()
            do {
                cities = try decoder.decode([City].self, from: data)
            } catch {
                print("Error Decoder: \(error.localizedDescription)")
            }
        }
    }
}
