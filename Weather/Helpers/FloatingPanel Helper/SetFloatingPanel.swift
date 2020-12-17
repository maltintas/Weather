//
//  SetFloatingPanel.swift
//  Weather
//
//  Created by Mehmet on 16.12.2020.
//  Copyright © 2020 Mehmet. All rights reserved.
//

import Foundation
import FloatingPanel

class SetFloatingPanel {
    func onfigureContentViewController(fpc: FloatingPanelController, parentVC: UIViewController, contentViewController: UIViewController) {
        fpc.set(contentViewController: contentViewController)
        fpc.contentMode = .fitToBounds
        fpc.layout = MyFloatingPanelLayout()
        fpc.addPanel(toParent: parentVC)
        fpc.move(to: .tip, animated: true)
        fpc.setApperance()
    }
}
