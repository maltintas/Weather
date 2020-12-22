//
//  DailyView.swift
//  Weather
//
//  Created by Mehmet on 22.12.2020.
//  Copyright © 2020 Mehmet. All rights reserved.
//

import UIKit

class DailyView: UIView {
    
    //MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - Properties
    var allDailyWeatherData: [DailyWeatherData] = []
    
    //MARK: - Helper Methods
    func configureView(){
        configureTableView()
        self.frame.size.height = 480
        self.frame.size.width = 365
        self.frame.origin.x = 5
        self.frame.origin.y = 5
        self.layer.cornerRadius = 40
        tableView.layer.cornerRadius = 40
    }
    
    func configureAllWeatherData(newData: [DailyWeatherData]){
        if !allDailyWeatherData.isEmpty{
            allDailyWeatherData.removeAll()
            allDailyWeatherData.append(contentsOf: newData)
            allDailyWeatherData.removeFirst()
            tableView.reloadData()
        } else {
            allDailyWeatherData.append(contentsOf: newData)
            allDailyWeatherData.removeFirst()
            tableView.reloadData()
        }
    }
    
    func configureTableView(){
        tableView.dataSource = self
        tableView.register(DaysTableViewCell.nib(), forCellReuseIdentifier: DaysTableViewCell.identifier)
    }
    
    static func loadNib(owner: UIViewController) -> Any? {
        Bundle.main.loadNibNamed("DailyView", owner: owner, options: nil)?.first
    }

}

extension DailyView: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if allDailyWeatherData.isEmpty {
            return 1
        }
        return allDailyWeatherData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DaysTableViewCell.identifier, for: indexPath) as! DaysTableViewCell
        
        if !allDailyWeatherData.isEmpty{
            let dailyWeatherViewModel = DailyWeatherViewModel(dailyWeatherData: allDailyWeatherData[indexPath.row])
            dailyWeatherViewModel.configure(cell: cell)
            return cell
        } else {
            cell.dayLabel.text = "Opps..."
            cell.maxTempLabel.text = "🙀"
            cell.minTempLabel.text = "😿"
            cell.iconImage.image = UIImage(systemName: "exclamationmark.triangle")
            cell.iconImage.tintColor = .systemRed
            return cell
        }
    }
    
}
