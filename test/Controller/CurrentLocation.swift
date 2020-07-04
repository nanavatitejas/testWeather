// CurrentLocationViewController.swift
//  test
//
//  Created by Tejas Nanavati on 03/07/20.
//  Copyright © 2020 Tejas Nanavati. All rights reserved.
//




import UIKit
import CoreLocation

class MainViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    
    @IBOutlet weak var sunsetLabel: UILabel!
    @IBOutlet weak var sunriseLabel: UILabel!
    @IBOutlet weak var visibilityLabel: UILabel!
    @IBOutlet weak var windLabel: UILabel!
    @IBOutlet weak var tmpLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var mainIcon: UIImageView!
    
    
    private let CLManager = CLLocationManager()
    private let geoCoder = CLGeocoder()
    private var cityName = ""
    
    private var weather: WeatherForcast? = nil {
        didSet {
            self.title = cityName
            self.sunsetLabel.text =  "Sunset: " + self.weather!.sunsetTime
            self.sunriseLabel.text =  "Sunrise: " + self.weather!.sunriseTime
            self.visibilityLabel.text =  "Visibility: " + self.weather!.visibility
            self.windLabel.text = "Wind: " + self.weather!.windDeg + " " + self.weather!.windSpeed +  "m/s"
            let temp = Double(self.weather!.tmp)
            self.tmpLabel.text = Helper.getDegreeCelsius(temprature: temp ?? 0, convertToCelsius: true)
            self.descriptionLabel.text = self.weather?.description
            self.mainIcon.image = UIImage(named: (self.weather?.imgCode)!)
        }
    }
    
    private var weatherFor5: WeatherFor5Days? = nil {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpLocationManager()
        NotificationCenter.default.addObserver(self, selector: #selector(needToRefreshData), name: .didChangeData, object: nil)
        needToRefreshData()
    }

    @objc private func needToRefreshData() {
        turnOffInterface()
        CLManager.requestLocation()
    }
    
    
    deinit {
        CLManager.delegate = nil
    }
    
}



// - MARK: LOCATION STUFF
extension MainViewController: CLLocationManagerDelegate {
    private func setUpLocationManager() {
        CLManager.delegate = self
        CLManager.requestWhenInUseAuthorization()
        CLManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        CLManager.requestLocation()
    }


    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { print("no location"); return }
        geoCoder.reverseGeocodeLocation(location, preferredLocale: Locale.init(identifier: "en_US")) { [weak self] (placemarks, error) in
            guard let _ = self else { return }
            if let _ = error {
                self?.showAlert(with: error!.localizedDescription)
                return
            }
            guard let placemark = placemarks?.first else {
                print("No placemarks")
                return
            }
            if let city = placemark.locality, let code = placemark.isoCountryCode {
                self?.cityName = city
                print(city)
                
                
                NetworkManager.shared.getCurrentWeather(city: city, code: code) { dict in
                    guard let tmp = dict else { print("nil nil nil"); return }
                    DispatchQueue.main.async {
                         self?.weather = WeatherForcast(json: tmp)
                        self!.turnOnInterface()
                    }
                   
                }
                NetworkManager.shared.getWeatherFor5Days(city:city) { dict in
                    guard let tmp = dict else { print("nil nil nil"); return }
                    DispatchQueue.main.async {
                        self?.weatherFor5 = WeatherFor5Days(json: tmp)
                    }
                }
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        turnOnInterface()
        if self.presentedViewController == nil {
            showAlert(with: "Error getting user location. Turn on location services or change permissions and restart the application")
        }
    }
}



// TABLE
extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return weatherFor5?.days.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weatherFor5?.days[section].count ?? 1
    }
    
 
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if weatherFor5?.days == nil { return nil }
        
        let f = DateFormatter()
        f.locale = Locale.init(identifier: "en")
        if weatherFor5?.days[section].first == nil {
            return f.weekdaySymbols[Calendar.current.component(.weekday, from: Date()) - 1]
        }
        let tmp = f.weekdaySymbols[Calendar.current.component(.weekday, from: ((weatherFor5?.days[section].first)!.date)) - 1]
        return  tmp
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if weatherFor5 == nil { return UITableViewCell() }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "weatherCell")
        if let rightDay = weatherFor5?.days[indexPath.section][indexPath.row] {
            cell?.textLabel?.text = rightDay.time
            
            let description = rightDay.description
            
            
            let temp = Double(rightDay.tmp)
            let tmpStr = Helper.getDegreeCelsius(temprature: temp ?? 0,convertToCelsius: true)
            
            
            cell?.detailTextLabel?.text =  description +  ", " +  tmpStr
            cell?.imageView?.image = UIImage(named: rightDay.imgCode)
            return cell!
        }
        return UITableViewCell()
    }
    
}


