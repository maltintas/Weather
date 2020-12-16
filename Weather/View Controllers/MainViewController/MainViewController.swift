//
//  MainViewController.swift
//  Weather
//
//  Created by Mehmet on 15.12.2020.
//  Copyright © 2020 Mehmet. All rights reserved.
//

import UIKit
import MapKit
import FloatingPanel

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
    let locationManager = CLLocationManager()
    let locationService = LocationServices()
    let fpc = FloatingPanelController()
    lazy var contentVC = ContentViewController(nibName: "ContentViewController", bundle: nil)
    let setFloatingPanel = SetFloatingPanel()
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        configureCollectionViewCell()
        getWeatherData()
        
        locationService.checkLocationServices(locationManager: locationManager, viewController: self)
        locationManager.delegate = self
        
        setFloatingPanel.onfigureContentViewController(fpc: fpc, parentVC: self, contentViewController: contentVC)
        fpc.track(scrollView: contentVC.tableView)
        fpc.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        contentVC.searchBar.delegate = self
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

//MARK: - CLLocationManagerDelegate
extension MainViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        locationService.checkAuthorizationForLocation(locationManager: locationManager, viewController: self)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location Manager Error: \(error.localizedDescription)")
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        getWeatherData(currentLocation: location)
    }
}

//MARK: - FloatingPanelControllerDelegate

extension MainViewController: FloatingPanelControllerDelegate {
    func floatingPanelWillBeginDragging(_ fpc: FloatingPanelController) {
        if fpc.state == .full {
            contentVC.searchBar.showsCancelButton = false
            contentVC.searchBar.resignFirstResponder()
        }
    }
    
    func floatingPanelWillEndDragging(_ fpc: FloatingPanelController, withVelocity velocity: CGPoint, targetState: UnsafeMutablePointer<FloatingPanelState>) {
        if targetState.pointee != .tip {
            fpc.contentMode = .static
        }
    }
    
    func floatingPanelDidEndAttracting(_ fpc: FloatingPanelController) {
        fpc.contentMode = .fitToBounds
    }
}

//MARK: - UISearchBarDelegate

extension MainViewController: UISearchBarDelegate {
    func active(searchBar: UISearchBar) {
        contentVC.searchBar.showsCancelButton = true
        contentVC.tableView.alpha = 1.0
    }
    
    func deactive(searchBar: UISearchBar) {
        contentVC.searchBar.resignFirstResponder()
        contentVC.searchBar.showsCancelButton = false
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        deactive(searchBar: searchBar)
        UIView.animate(withDuration: 0.45) {
            self.fpc.move(to: .tip, animated: false)
        }
        searchBar.text = ""
        DispatchQueue.main.async {
            self.contentVC.matchedItems.removeAll()
            self.contentVC.tableView.reloadData()
        }
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        active(searchBar: searchBar)
        UIView.animate(withDuration: 0.45) {
            self.fpc.move(to: .full, animated: false)
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = searchText
        
        let search = MKLocalSearch(request: request)
        search.start { (response, _) in
            guard let response = response else {return }
            self.contentVC.matchedItems = response.mapItems
            DispatchQueue.main.async {
                self.contentVC.tableView.reloadData()
            }
        }
    }
}
