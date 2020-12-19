//
//  SearchResultTableViewCell.swift
//  Weather
//
//  Created by Mehmet on 17.12.2020.
//  Copyright © 2020 Mehmet. All rights reserved.
//

import UIKit

class SearchResultTableViewCell: UITableViewCell {

    //MARK: - Properties
    static let identifier = "SearchResultTableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //MARK: - Helper Methods
    
    static func nib() -> UINib {
        return UINib(nibName: "SearchResultTableViewCell", bundle: nil)
    }
    
}
