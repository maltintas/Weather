//
//  MyFloatingPanelLayout.swift
//  Weather
//
//  Created by Mehmet on 16.12.2020.
//  Copyright © 2020 Mehmet. All rights reserved.
//

import Foundation
import FloatingPanel

public class MyFloatingPanelLayout: FloatingPanelLayout {
    public var position: FloatingPanelPosition {
        .bottom
    }
    
    public var initialState: FloatingPanelState {
        .half
    }
    
    public var anchors: [FloatingPanelState : FloatingPanelLayoutAnchoring] {
        return [
            .full: FloatingPanelLayoutAnchor(absoluteInset: 128.0, edge: .top, referenceGuide: .safeArea),
            .half: FloatingPanelLayoutAnchor(fractionalInset: 0.5, edge: .bottom, referenceGuide: .safeArea),
            .tip: FloatingPanelLayoutAnchor(absoluteInset: 57, edge: .bottom, referenceGuide: .safeArea)
            ]
    }
    public func backdropAlpha(for state: FloatingPanelState) -> CGFloat {
        return 0.0
    }
    
}
