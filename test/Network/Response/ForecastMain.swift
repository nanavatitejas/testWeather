//
//  ForecastMain.swift
//

import Foundation

struct ForecastMain {
    let temp: Double
    let feelsLike: Double
    let pressure: Int
    let humidity: Int
}

extension ForecastMain: Codable {
    
    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case pressure
        case humidity
    }
}
