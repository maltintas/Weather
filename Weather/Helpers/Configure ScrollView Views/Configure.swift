//
//  Configure.swift
//  Weather
//
//  Created by Mehmet on 19.12.2020.
//  Copyright © 2020 Mehmet. All rights reserved.
//

import Foundation
import UIKit

class Configure {
    
    func configureTableView(tableView: TableView, xOrigin: CGFloat, cornerRadius: CGFloat){
        tableView.frame.size.height = 480
        tableView.frame.size.width = 365
        tableView.frame.origin.x = xOrigin
        tableView.frame.origin.y = 5
        tableView.layer.cornerRadius = cornerRadius
        tableView.tableView.layer.cornerRadius = cornerRadius
    }
    
    func configureView(view: CurrentView, xOrigin: CGFloat, cornerRadius: CGFloat){
        view.frame.size.height = 480
        view.frame.size.width = 365
        view.frame.origin.x = xOrigin
        view.frame.origin.y = 5
        view.layer.cornerRadius = cornerRadius
        view.containerView.layer.cornerRadius = cornerRadius
    }
    
}
