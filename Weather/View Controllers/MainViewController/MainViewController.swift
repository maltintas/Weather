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

    let scrollView = UIScrollView()
    let pageControl: UIPageControl = {
       let pageControl = UIPageControl()
        pageControl.numberOfPages = 3
        pageControl.currentPage = 1
        pageControl.currentPageIndicatorTintColor = .systemYellow
        pageControl.pageIndicatorTintColor = .systemGray
        return pageControl
    }()
    var allViews: [UIView] = []
    lazy var currentViewObject = CurrentView()
    lazy var detailViewObject = DetailUIView()
    lazy var daysViewObject = DailyView()
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureSubViews()
        scrollView.delegate = self
               pageControl.addTarget(self, action: #selector(pageControlDidChange(_:)), for: .valueChanged)
               view.addSubview(scrollView)
               view.addSubview(pageControl)
        
        
        configureCollectionViewCell()
        getWeatherData()
        
        locationService.checkLocationServices(locationManager: locationManager, viewController: self)
        locationManager.delegate = self
        
        setFloatingPanel.onfigureContentViewController(fpc: fpc, parentVC: self, contentViewController: contentVC)
        fpc.track(scrollView: contentVC.tableView)
        fpc.delegate = self
        
        configureContentView()
        
       
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        pageControl.frame = CGRect(x: 20, y: view.frame.size.height - 195, width: view.frame.size.width - 20, height: 10)
        scrollView.frame = CGRect(x: 0, y: 130, width: view.frame.size.width, height: 490)
        
        if scrollView.subviews.count == 2 {
            configureScrollView()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        contentVC.searchBar.delegate = self
    }
    
    //MARK: - Helper Methods
    func contentGetWeatherHelper(latitude: Double, longitude: Double, fpc: FloatingPanelController){
        getWeatherData(currentLocation: CLLocation(latitude: latitude, longitude: longitude))
        UIView.animate(withDuration: 0.40) {
            fpc.move(to: .tip, animated: false)
        }
    }
    
    @objc func pageControlDidChange(_ sender: UIPageControl){
        let current = sender.currentPage
        scrollView.setContentOffset(CGPoint(x: CGFloat(current) * view.frame.size.width, y: 0), animated: true)
    }
    
    func configureScrollView(){
        scrollView.contentSize = CGSize(width: view.frame.size.width * 3, height: scrollView.frame.size.height)
        scrollView.isPagingEnabled = true
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        
        for view in 0..<allViews.count {
            let page = UIView(frame: CGRect(x: 0, y: 0, width: scrollView.frame.size.width, height: scrollView.frame.size.height))
            page.addSubview(allViews[view])
            scrollView.addSubview(page)
        }
        //Start with middle View
        self.scrollView.contentOffset = CGPoint(x: 375, y: 5)
    }
    //MARK: - Configure SubViews
    func configureSubViews(){
    
        if let weatherDayView = DailyView.loadNib(owner: self) as? DailyView {
        weatherDayView.configureView()
        daysViewObject = weatherDayView
        allViews.append(weatherDayView)
        
        }
            
        if let curretView = CurrentView.loadNib(owner: self) as? CurrentView {
            curretView.configureView()
            currentViewObject = curretView
            allViews.append(curretView)
        }
        
        
        if let detailView = DetailUIView.loadNib(owner: self) as? DetailUIView {
            detailView.configureView()
            detailViewObject = detailView
            allViews.append(detailView)
        }
    }

    //MARK: - Network
    
    func getWeatherData(currentLocation: CLLocation = CLLocation(latitude: (41.043163), longitude: (29.007007))){
        WeatherClient.getWeather(latitude: "\(currentLocation.coordinate.latitude)", longitude: "\(currentLocation.coordinate.longitude)") {
            [unowned self]  (data, error) in
            print("Get Weather Error: \(String(describing: error?.localizedDescription))")
            if error?.localizedDescription == "URLSessionTask failed with error: The Internet connection appears to be offline." {
                self.fireAlertMessage.alertMessage(message: "Please check your network connection.", viewController: self)
            }
            
            guard let currentWeather = data?.currently else { return }
            guard let dailyWeatherData = data?.daily?.dailyData else { return }
            guard let firstDailyWeatherData = data?.daily?.dailyData?.first else { return }
            guard let hourlyData = data?.hourly?.hourlyData else {return }

            
            self.daysViewObject.configureAllWeatherData(newData: dailyWeatherData)
            
            let currentWeatherViewModel = CurrentWeatherViewModel(currentWeatherData: currentWeather, dailyWeatherData: firstDailyWeatherData, city: self.contentVC.city)
            currentWeatherViewModel.configureTopUIElements(mainVC: self)
            currentWeatherViewModel.configureMidUIElements(currentView: self.currentViewObject)
            
            let detailWeatherViewModel = DetailWeatherViewModel(dailyWeatherData: dailyWeatherData.first!)
            detailWeatherViewModel.configureDetailView(detailView: self.detailViewObject)
            
            
            DispatchQueue.main.async {
                self.hourlyWeatherData = hourlyData
                self.hourlyWeatherDataCollectionView.reloadData()
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

//MARK: - ContentViewController - TableView Delegate
extension MainViewController: UITableViewDelegate {
    func configureContentView() {
        contentVC.loadViewIfNeeded()
        contentVC.tableView.delegate = self
        contentVC.searchBar.placeholder = "Searh city"
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView.tag == 1003 {
            tableView.deselectRow(at: indexPath, animated: true)
            deactive(searchBar: contentVC.searchBar)
            
            if indexPath.section == 0 {
                let matchedItemLatitude = contentVC.matchedItems[indexPath.row].placemark.coordinate.latitude
                let matchedItemLongitude = contentVC.matchedItems[indexPath.row].placemark.coordinate.longitude
                
                //Prevent to add same city to cities array
                guard let cityName = contentVC.matchedItems[indexPath.row].name else { return }
                for city in 0..<contentVC.cities.count {
                    guard cityName != contentVC.cities[city].name else {return }
                }
                DispatchQueue.main.async {
                    self.contentVC.cities.insert(City(name: self.contentVC.matchedItems[indexPath.row].name ?? "No City Information", cityLatitude: self.contentVC.matchedItems[indexPath.row].placemark.coordinate.latitude , cityLongitude: self.contentVC.matchedItems[indexPath.row].placemark.coordinate.longitude), at: 0)
                    self.contentGetWeatherHelper(latitude: matchedItemLatitude, longitude: matchedItemLongitude, fpc: self.fpc)
                    self.contentVC.city = self.contentVC.cities[indexPath.row]
                    self.contentVC.save.saveCity(cities: self.contentVC.cities)
                    self.contentVC.matchedItems.removeAll()
                    self.contentVC.searchBar.text = ""
                    self.contentVC.tableView.reloadData()
                }
            } else if indexPath.section == 1 {
                let citiesLatitude = contentVC.cities[indexPath.row].cityLatitude
                let citiesLongitude = contentVC.cities[indexPath.row].cityLongitude
                contentGetWeatherHelper(latitude: citiesLatitude, longitude: citiesLongitude, fpc: fpc)
                self.contentVC.city = self.contentVC.cities[indexPath.row]
            }
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView.tag == 1003 {
            if indexPath.section == 0 {
                return 64
            } else {
                return 50
            }
        }
        return 50
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
      
        guard tableView.tag == 1003 else { return UIView()}
            
            let header: UIView = {
                let searchResultHeader = UIView()
                searchResultHeader.backgroundColor = .fontColor()
                searchResultHeader.isHidden = true
                return searchResultHeader
            }()
            
                let headerLabel: UILabel = {
                    let searchResultLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 370, height: 32))
                    searchResultLabel.textColor = .headerColor()
                    searchResultLabel.textAlignment = .center
                    searchResultLabel.font = UIFont(name: "Apple-SD-Gothic-Neo-Bold", size: 38)
                    if section == 0 && contentVC.matchedItems.count == 0 {
                        searchResultLabel.text = ""
                    } else {
                        header.isHidden.toggle()
                        searchResultLabel.text = "Search Results"
                    }
                    header.addSubview(searchResultLabel)
                    return searchResultLabel
                }()
                header.addSubview(headerLabel)
                return header
    }
    
}
//MARK: - UIScrollViewDelegate
extension MainViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        guard !scrollView.isKind(of: UICollectionView.self) else { return }
        
        pageControl.currentPage = Int(floorf(Float(scrollView.contentOffset.x) / Float(scrollView.frame.size.width)))
    }
}
