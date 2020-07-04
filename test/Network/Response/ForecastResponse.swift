//
//  ForecastResponse.swift
//

import Foundation

struct ForecastResponse {
    
    let code: String?
    let message: Int?
    let count: Int?
    let items: [ForecastItem]?
    let city: City?
}

extension ForecastResponse: Decodable {
    
    enum CodingKeys: String, CodingKey {
        case code = "cod"
        case message
        case count = "cnt"
        case items = "list"
        case city
    }
}
