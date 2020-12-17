//
//  FloatingPanel+Extension.swift
//  Weather
//
//  Created by Mehmet on 16.12.2020.
//  Copyright © 2020 Mehmet. All rights reserved.
//

import Foundation
import FloatingPanel

extension FloatingPanelController {
    func setApperance() {
        let apperance = SurfaceAppearance()
        apperance.cornerRadius = 8.0
        apperance.backgroundColor = .clear
        surfaceView.appearance = apperance
    }
}
