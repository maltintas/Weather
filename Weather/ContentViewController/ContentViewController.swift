//
//  ContentViewController.swift
//  Weather
//
//  Created by Mehmet on 16.12.2020.
//  Copyright © 2020 Mehmet. All rights reserved.
//

import UIKit
import MapKit

class ContentViewController: UIViewController {
    //MARK: - Outlets
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - Properties
    var matchedItems: [MKMapItem] = []
    var cities: [City] = []
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.tableFooterView = UIView()
        tableView.dataSource = self
        
        tableView.register(SearchResultTableViewCell.nib(), forCellReuseIdentifier: SearchResultTableViewCell.identifier)
        tableView.register(CityTableViewCell.nib(), forCellReuseIdentifier: CityTableViewCell.identifier)
    }



}

//MARK: - TableView DataSource
extension ContentViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return matchedItems.count
        } else {
            return cities.count
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 && matchedItems.count == 0 {
            return ""
        } else if section == 0 {
            return "Search Results"
        } else {
            return "Saved Cities"
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let searchResultCell = tableView.dequeueReusableCell(withIdentifier: SearchResultTableViewCell.identifier, for: indexPath) as! SearchResultTableViewCell
            searchResultCell.textLabel?.text = matchedItems[indexPath.row].name
            return searchResultCell
        } else {
            let cityCell = tableView.dequeueReusableCell(withIdentifier: CityTableViewCell.identifier, for: indexPath) as! CityTableViewCell
            cityCell.textLabel?.text = cities[indexPath.row].name
            return cityCell
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            if editingStyle == .delete {
                cities.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
                
            }
        }
    }
    
}
