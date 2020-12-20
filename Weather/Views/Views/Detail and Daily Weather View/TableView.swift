//
//  TableView.swift
//  Weather
//
//  Created by Mehmet on 19.12.2020.
//  Copyright © 2020 Mehmet. All rights reserved.
//

import UIKit

class TableView: UIView {

    @IBOutlet weak var tableView: UITableView!
    
    static func loadNib(owner: UIViewController) -> Any? {
        Bundle.main.loadNibNamed("TableView", owner: owner, options: nil)?.first
    }
}
