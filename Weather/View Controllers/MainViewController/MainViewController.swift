//
//  MainViewController.swift
//  Weather
//
//  Created by Mehmet on 15.12.2020.
//  Copyright © 2020 Mehmet. All rights reserved.
//

import UIKit
import MapKit

class MainViewController: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var maxMinTempLabel: UILabel!
    @IBOutlet weak var currentWeatherImageview: UIImageView!
    @IBOutlet weak var currentTempLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var sunRiseTimeLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    @IBOutlet weak var precipIcon: UIImageView!
    @IBOutlet weak var precipProbability: UILabel!
    @IBOutlet weak var hourlyWeatherDataCollectionView: UICollectionView!
    
    
    //MARK: - Properties
    let fireAlertMessage = AlertMessage()
    let configureIcon = ConfigureIcons()
    var hourlyWeatherData: [HourlyWeatherData] = []
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        configureCollectionViewCell()
        getWeatherData()
        
    }

    //MARK: - Network
    
    func getWeatherData(currentLocation: CLLocation = CLLocation(latitude: (41.043163), longitude: (29.007007))){
        WeatherClient.getWeather(latitude: "\(currentLocation.coordinate.latitude)", longitude: "\(currentLocation.coordinate.longitude)") {[weak self] (data, error) in
            print("Get Weather Error: \(String(describing: error?.localizedDescription))")
            if error?.localizedDescription == "URLSessionTask failed with error: The Internet connection appears to be offline." {
                self?.fireAlertMessage.alertMessage(message: "Please check your network connection.", viewController: self!)
            }
            
            guard let currentWeather = data?.currently else { return }
            guard let firstDailyWeatherData = data?.daily?.dailyData?.first else { return }
            guard let hourlyData = data?.hourly?.hourlyData else {return }
            
            let currentWeatherViewModel = CurrentWeatherViewModel(currentWeatherData: currentWeather, dailyWeatherData: firstDailyWeatherData)
            currentWeatherViewModel.configureUIElements(mainVC: self!)
            
            DispatchQueue.main.async {
                self?.hourlyWeatherData = hourlyData
                self?.hourlyWeatherDataCollectionView.reloadData()
            }
        }
    }
    
    //MARK: - CollectionView
    func configureCollectionViewCell() {
        hourlyWeatherDataCollectionView.delegate = self
        hourlyWeatherDataCollectionView.dataSource = self
        hourlyWeatherDataCollectionView.register(HourlyCollectionViewCell.nib(), forCellWithReuseIdentifier: HourlyCollectionViewCell.identifier)
    }
}

//MARK: - Collection View DataSource & Delegate

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        hourlyWeatherData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HourlyCollectionViewCell.identifier, for: indexPath) as! HourlyCollectionViewCell
        let hourlyViewModel = HourlyViewModel(hourlyWeatherData: hourlyWeatherData[indexPath.row])
        hourlyViewModel.configureHourlyCollectionViewCell(cell: cell)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 100)
    }
    
}
