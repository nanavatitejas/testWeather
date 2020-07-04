

import Foundation

// MARK: - Forcast
struct Forcast: Decodable {
    let cod: String?
    let message, cnt: Int?
    let list: [List1]?
    let city: City1?
}

// MARK: - City
struct City1: Decodable {
    let id: Int?
    let name: String?
    let coord: Coord2?
    let country: String?
    let population, timezone, sunrise, sunset: Int?
}

// MARK: - Coord
struct Coord2: Decodable {
    let lat, lon: Double?
}

// MARK: - List
struct List1: Decodable {
    let dt: Int?
    let main: MainClass?
    let weather: [Weather2]?
    let clouds: Clouds2?
    let wind: Wind2?
    let sys: Sys2?
    let dtTxt: String?
    let rain: Rain?

    enum CodingKeys: String, CodingKey {
        case dt, main, weather, clouds, wind, sys
        case dtTxt = "dt_txt"
        case rain
    }
}

// MARK: - Clouds
struct Clouds2: Decodable {
    let all: Int?
}

// MARK: - MainClass
struct MainClass: Decodable {
    let temp, feelsLike, tempMin, tempMax: Double?
    let pressure, seaLevel, grndLevel, humidity: Int?
    let tempKf: Double?

    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure
        case seaLevel = "sea_level"
        case grndLevel = "grnd_level"
        case humidity
        case tempKf = "temp_kf"
    }
}

// MARK: - Rain
struct Rain: Decodable {
    let the3H: Double?

    enum CodingKeys: String, CodingKey {
        case the3H = "3h"
    }
}

// MARK: - Sys
struct Sys2: Decodable {
    let pod: Pod?
}

enum Pod: String, Decodable {
    case d = "d"
    case n = "n"
}

// MARK: - Weather
struct Weather2: Decodable {
    let id: Int?
    let main: MainEnum?
    let weatherDescription: Description?
    let icon: String?

    enum CodingKeys: String, CodingKey {
        case id, main
        case weatherDescription = "description"
        case icon
    }
}

enum MainEnum: String, Decodable {
    case clear = "Clear"
    case clouds = "Clouds"
    case rain = "Rain"
}

enum Description: String, Decodable {
    case brokenClouds = "broken clouds"
    case clearSky = "clear sky"
    case fewClouds = "few clouds"
    case lightRain = "light rain"
    case overcastClouds = "overcast clouds"
    case scatteredClouds = "scattered clouds"
}

// MARK: - Wind
struct Wind2: Decodable {
    let speed: Double?
    let deg: Int?
}
