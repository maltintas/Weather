//
//  DetailUIView.swift
//  Weather
//
//  Created by Mehmet on 21.12.2020.
//  Copyright © 2020 Mehmet. All rights reserved.
//

import UIKit

class DetailUIView: UIView {

    //MARK: - Outlets
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var sunSetTimeLabel: UILabel!
    @IBOutlet weak var dewPointLabel: UILabel!
    @IBOutlet weak var pressureLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var visibilityLabel: UILabel!
    @IBOutlet weak var uvIndexLabel: UILabel!
    @IBOutlet weak var TempHighLabel: UILabel!
    @IBOutlet weak var tempLowLabel: UILabel!
    @IBOutlet weak var darkSkyButton: UIButton!
    
    
    //MARK: - Helper Methods
    func configureView() {
        self.frame.size.height = 480
        self.frame.size.width = 365
        self.frame.origin.x = 755
        self.frame.origin.y = 5
        self.layer.cornerRadius = 40
        containerView.layer.cornerRadius = 40
    }
    
    static func loadNib(owner: UIViewController) -> Any? {
        Bundle.main.loadNibNamed("DetailView", owner: owner, options: nil)?.first
    }
}
