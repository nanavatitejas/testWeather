//
//  ForecastRequest.swift
//


import Foundation

struct ForecastRequest: ApiRequest {
    typealias ResponseType = ForecastResponse
    
    var path = "forecast"
    
    var params: [String: String] {
        [
            "appid": "9b3f2f9d2a2e963aa76b00e07a59227c",
            "mode": "json(UNITS)",
            "units": "metric",
            "q": city
        ]
    }
    
    var method = HTTPMethod.get
    
    // MARK: Private Properties
    private var city: String
    
    // MARK: Life Cycle
    init(city: String) {
        self.city = city
    }
}
