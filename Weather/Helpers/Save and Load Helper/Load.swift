//
//  Load.swift
//  Weather
//
//  Created by Mehmet on 17.12.2020.
//  Copyright © 2020 Mehmet. All rights reserved.
//

import Foundation
class Load {
    public static let shared = Load()
    let documentCode = DocumentsCodes()
    

     func cityLoad() -> [City] {
        let path = documentCode.dataFilePath()
        guard let data = try? Data(contentsOf: path) else {
            return []
        }
        let decoder = PropertyListDecoder()
        do {
            return try decoder.decode([City].self, from: data)
        } catch {
            print("Error Decoder: \(error.localizedDescription)")
            return []
        }
    }
}
