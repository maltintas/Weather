//
//  DaysTableViewCell.swift
//  Weather
//
//  Created by Mehmet on 19.12.2020.
//  Copyright © 2020 Mehmet. All rights reserved.
//

import UIKit

class DaysTableViewCell: UITableViewCell {
    
    static let identifier = "DaysTableViewCell"

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "DaysTableViewCell", bundle: nil)
    }
    
}
