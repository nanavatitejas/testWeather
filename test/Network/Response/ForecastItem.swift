//
//  ForecastItem.swift
//

import Foundation

struct ForecastItem {
    let date: Date
    let main: ForecastMain
    let weather: [Weather]
}

extension ForecastItem: Decodable {
    
    enum CodingKeys: String, CodingKey {

        case date = "dt"
        case main = "main"
        case weather = "weather"
    }
}
