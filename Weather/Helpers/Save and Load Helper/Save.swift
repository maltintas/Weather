//
//  Save.swift
//  Weather
//
//  Created by Mehmet on 17.12.2020.
//  Copyright © 2020 Mehmet. All rights reserved.
//

import Foundation
class Save {
    let documentCodes = DocumentsCodes()
    
    func saveCity(cities: [City]) {
        let encoder = PropertyListEncoder()
        do {
            let data = try encoder.encode(cities)
            try data.write(to: documentCodes.dataFilePath())
        } catch {
            print("Error Encoder: \(error.localizedDescription) ")
        }
        print("Document Directory\(documentCodes.dataFilePath())")
    }
}
