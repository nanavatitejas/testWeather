//
//  WeatherForcast.swift
//  test
//
//  Created by Tejas Nanavati on 03/07/20.
//  Copyright © 2020 Tejas Nanavati. All rights reserved.
//

import Foundation

import Foundation

struct WeatherForcast {
    
    var sunriseTime  = "Error"
    var sunsetTime   = "Error"
    var tmp          = "Error"
    var visibility   = "Error"
    var windSpeed    = "Error"
    var windDeg      = "Error"
    var description  = "Error"
    var imgCode      = "Error"
    var date         = Date()
    var time         = "Error"
    
    
    
    init(json: Dictionary<String, Any>) {
        if let visibility = json["visibility"] as? Int {
            self.visibility = visibility.description + " m"
        } else { self.visibility = "0" }
        if let sys = json["sys"] as? Dictionary<String, Any> {
            if let sunrise = sys["sunrise"] as? Double {
                self.sunriseTime = WeatherForcast.getTime(since1970: sunrise)
            }
            if let sunset = sys["sunset"] as? Double {
                self.sunsetTime = WeatherForcast.getTime(since1970: sunset)
            }
        }

        if let wind = json["wind"] as? Dictionary<String, Double> {
            self.windSpeed = wind["speed"]?.description ?? "0"
            self.windDeg = WeatherForcast.getWindDirection(by:(wind["deg"] ?? 0))
        }
        if let weather = json["weather"] as? Array<Dictionary<String, Any>> {
            self.description = weather.first?["description"] as? String ?? "Error"
            self.description.capitalizeFirstLetter()
            self.imgCode = weather.first?["icon"] as? String ?? "01d"
        }
        if let main = json["main"] as? Dictionary<String, Double> {
            self.tmp = Int(main["temp"] ?? 0).description
        }
        if let time = json["dt"] as? Int {
            self.date = Date(timeIntervalSince1970: Double(time))
            self.time = WeatherForcast.getTime(since1970: Double(time))
        }
        
    
    }
}


extension WeatherForcast{
    static func getTime(since1970: Double) -> String {
        let date = Date(timeIntervalSince1970: since1970)
        let formatter = DateFormatter()
        formatter.timeZone = .current
        formatter.dateFormat = "HH:mm"
        
        return formatter.string(from: date)
    }
    
    static func getWindDirection(by degrees: Double) -> String {
        switch degrees {
        case 33.75...78.75:
            return "NE"
        case 78.75...123.75:
            return "E"
        case 123.75...168.75:
            return "SE"
        case 168,75...213.75:
            return "SW"
        case 213.75...258.75:
            return "W"
        case 258.75...326.25:
            return "NW"
        default:
            return "N"
        }
    }
}





struct WeatherFor5Days  {
    
    var days: [[WeatherForcast]] = [[], [], [], [], [], []]

    
    init(json: Dictionary<String, Any>) {
        if let list = json["list"] as? Array<Dictionary<String, Any>> {
            var forcast = [WeatherForcast]()
            for elem in list {
                forcast.append(WeatherForcast(json: elem))
            }
            sortWeatherByDays(with: forcast)
        }
    }
    
    mutating func sortWeatherByDays(with forcast: [WeatherForcast]) {
        var i = 0
        guard var prevDate = forcast.first?.date else { fatalError("Error extracting date from forcast") }
        for elem in forcast {
            if !elem.date.hasSame(Calendar.Component.day, as: prevDate) {
                i += 1
                prevDate = elem.date
            }
            days[i].append(elem)
        }
        print(days)
    }
}

