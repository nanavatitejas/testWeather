//
//  City.swift
//

import Foundation

struct City {
    let id: Int
    let name: String
    let country: String
    let timezoneSec: Int
}

extension City: Codable {
    
    enum CodingKeys: String, CodingKey {
        case id, name, country
        case timezoneSec = "timezone"
    }
}
