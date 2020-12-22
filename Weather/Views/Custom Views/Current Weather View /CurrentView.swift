//
//  CurrentView.swift
//  Weather
//
//  Created by Mehmet on 19.12.2020.
//  Copyright © 2020 Mehmet. All rights reserved.
//

import UIKit

class CurrentView: UIView {

   //MARK: - Outlets
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var currentTempLabel: UILabel!
    @IBOutlet weak var currentWeatherImageview: UIImageView!
    @IBOutlet weak var sunRiseTimeLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    @IBOutlet weak var precipIcon: UIImageView!
    @IBOutlet weak var precipProbability: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    
    //Helper Methods
    static func loadNib(owner: UIViewController) -> Any? {
        Bundle.main.loadNibNamed("CurrentView", owner: owner, options: nil)?.first
    }
    
    func configureView() {
        self.frame.size.height = 480
        self.frame.size.width = 365
        self.frame.origin.x = 380
        self.frame.origin.y = 5
        self.layer.cornerRadius = 40
        containerView.layer.cornerRadius = 40
    }
}
