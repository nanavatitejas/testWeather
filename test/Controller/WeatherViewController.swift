//
//  WeatherViewController.swift
//  test
//
//  Created by Tejas Nanavati on 03/07/20.
//  Copyright © 2020 Tejas Nanavati. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController {
    
    @IBOutlet weak var tblView: UITableView!
    var weather : Weather?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tblView.dataSource = self
        self.tblView.tableFooterView = UIView()
        
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //static IDS of city to display data
        self.getDetails(ids: [4350049,5101760,2158177])
    }
    
    @IBAction func btnMylocationPressed(_ sender: Any) {
        let sb = UIStoryboard.init(name: "Main", bundle: Bundle.main)
        let currentVC = sb.instantiateViewController(identifier: "MainViewController") as MainViewController
        self.navigationController?.pushViewController(currentVC, animated: true)
    }
    
    @IBAction func btnAddCityPressed(_ sender: Any) {
        let sb = UIStoryboard.init(name: "Main", bundle: Bundle.main)
        let cityVC = sb.instantiateViewController(identifier: "CityViewController") as CityViewController
        cityVC.delegate = self
        self.navigationController?.present(cityVC, animated: true, completion: nil)
        
    }
}

extension WeatherViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let objWeather = self.weather {
            return objWeather.list?.count ?? 0
        }
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let weatherCell = tableView.dequeueReusableCell(withIdentifier: "WaetherTableViewCell", for: indexPath) as! WaetherTableViewCell
        if indexPath.row == 0{
            weatherCell.backgroundColor = .cyan
        } else if indexPath.row == 1{
            weatherCell.backgroundColor = .lightGray
        } else {
            weatherCell.backgroundColor = .systemPurple
        }
        if let objWeather = self.weather {
            let objCity = objWeather.list?[indexPath.row]
            weatherCell.lblCityName.text = objCity?.name
            let minTemp = Helper.getDegreeCelsius(temprature: objCity?.main?.tempMin ?? 0.0, convertToCelsius: false)
            let maxTemp = Helper.getDegreeCelsius(temprature: objCity?.main?.tempMax ?? 0.0, convertToCelsius: false)
            weatherCell.lblTemp.text = minTemp + " / " + maxTemp
            weatherCell.lblWeatherDisc.text = objCity?.weather?[0].weatherDescription
            weatherCell.lblWind.text = objCity?.wind?.speed?.toString() ?? ""
        }
        return weatherCell
    }
    
    
}


extension WeatherViewController:selectedCityWeatherDetails{
    func getDetails(ids: [Int]) {
        
        var strIds = ""
        
        for i in 0..<ids.count{
            var strId = String(ids[i])
            if i + 1 == ids.count{
                strId = String(ids[i])
            } else {
                strId = strId + ","
            }
            strIds = strIds + strId
        }
        
        let urlstr = "http://api.openweathermap.org/data/2.5/group?id=\(strIds)&units=metric&APPID=75fdcaa60084b1a7b2a5fb02ef4bb7c9"
        
        guard let url = URL(string: urlstr) else {
            return
        }
        
        
        let request = URLRequest(url: url)
        
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                if let decodedResponse = try? JSONDecoder().decode(Weather.self, from: data) {
                    // we have good data – go back to the main thread
                    DispatchQueue.main.async {
                        self.weather = decodedResponse
                        self.tblView.reloadData()
                        // update our UI
                    }
                    
                    // everything is good, so we can exit
                    return
                }
            }
        }.resume()
        print(ids)
    }
    
    
    
    
}



extension Double {
    func toString() -> String {
        return String(format: "%.1f",self)
    }
}

extension WeatherViewController{
    func getDegreeCelsius(temprature:Double)->String{
        let measurement = Measurement(value: temprature, unit: UnitTemperature.celsius)
        
        let measurementFormatter = MeasurementFormatter()
        measurementFormatter.unitStyle = .short
        measurementFormatter.numberFormatter.maximumFractionDigits = 0
        measurementFormatter.unitOptions = .temperatureWithoutUnit
        
        return measurementFormatter.string(from: measurement) + "C"
    }
}
