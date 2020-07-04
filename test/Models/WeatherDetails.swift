//
//  WeatherDetails.swift
//  test
//
//  Created by Tejas Nanavati on 03/07/20.
//  Copyright © 2020 Tejas Nanavati. All rights reserved.
//

import Foundation

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let weather = try? newJSONDecoder().decode(Weather.self, from: jsonData)

import Foundation

// MARK: - Weather
struct Weather: Decodable {
    let cnt: Int?
    let list: [List]?
}

// MARK: - List
struct List: Decodable {
    let coord: Coord1?
    let sys: Sys?
    let weather: [WeatherElement]?
    let main: Main?
    let visibility: Int?
    let wind: Wind?
    let clouds: Clouds?
    let dt, id: Int?
    let name: String?
}

// MARK: - Clouds
struct Clouds: Codable {
    let all: Int?
}

// MARK: - Coord
struct Coord1: Decodable {
    let lon, lat: Double?
}

// MARK: - Main
struct Main: Decodable {
    let temp, feelsLike, tempMin, tempMax: Double?
    let pressure, humidity: Int?

    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure, humidity
    }
}

// MARK: - Sys
struct Sys: Decodable {
    let country: String?
    let timezone, sunrise, sunset: Int?
}

// MARK: - WeatherElement
struct WeatherElement: Decodable {
    let id: Int?
    let main, weatherDescription, icon: String?

    enum CodingKeys: String, CodingKey {
        case id, main
        case weatherDescription = "description"
        case icon
    }
}

// MARK: - Wind
struct Wind: Decodable {
    let speed: Double?
    let deg: Int?
}
