//
//  WeatherDetailView.swift
//  Weather
//
//  Created by Mehmet on 21.12.2020.
//  Copyright © 2020 Mehmet. All rights reserved.
//

import UIKit

class WeatherDetailView: UIView {

    @IBOutlet weak var tableView: UITableView!
    
     var dailyWeather = [DailyWeatherData]()


    func configureView(){
        configureTableView()

    }

    func configureTableView(){
        tableView.dataSource = self
        tableView.register(DetailTableViewCell.nib(), forCellReuseIdentifier: DetailTableViewCell.identifier)
    }

    static func loadNib(owner: UIViewController) -> Any? {
        Bundle.main.loadNibNamed("WeatherDetailView", owner: owner, options: nil)?.first
    }

}

extension WeatherDetailView: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 9
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DetailTableViewCell.identifier, for: indexPath) as! DetailTableViewCell

        if let firstDayDetail = dailyWeather.first{
            let detailViewModel = DetailWeatherViewModel(dailyWeatherData: firstDayDetail)
//            detailViewModel.configure(cell: cell, indexPath: indexPath)
            return cell
        } else {
            cell.detailLabel.text = "Houston, we have a problem"
            cell.iconImage.image = UIImage(systemName: "exclamationmark.triangle")
            cell.iconImage.tintColor = .systemRed
            return cell
        }
    }
    
}
