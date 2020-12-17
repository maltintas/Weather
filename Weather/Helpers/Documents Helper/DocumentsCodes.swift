//
//  DocumentsCodes.swift
//  Weather
//
//  Created by Mehmet on 17.12.2020.
//  Copyright © 2020 Mehmet. All rights reserved.
//

import Foundation

struct DocumentsCodes {
    func documentDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func dataFilePath() -> URL {
        return documentDirectory().appendingPathComponent("Cities").appendingPathExtension("plist")
    }
}
