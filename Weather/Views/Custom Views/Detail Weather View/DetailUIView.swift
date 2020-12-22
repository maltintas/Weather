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
    

    @IBAction func poweredBy(_ sender: UIButton) {
        
    }
    
    static func loadNib(owner: UIViewController) -> Any? {
        Bundle.main.loadNibNamed("DetailView", owner: owner, options: nil)?.first
    }
}
