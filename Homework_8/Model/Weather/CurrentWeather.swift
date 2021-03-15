//
//  CurrentWeather.swift
//  Homework_4
//
//  Created by Sasha on 19/01/2021.
//

import Foundation

struct CurrentWeather: Codable, Hashable {
    let id: Int
    let name: String
    let main: Main
    let weather: [Weather]
}

extension CurrentWeather {
    
    var cityName: String {
        return name
    }
    
    var temp: String {
        return "\(Int(main.temp))"
    }
    
    var minTemp: String {
        return "\(Int(main.tempMin))"
    }
    
    var maxTemp: String {
        return "\(Int(main.tempMax))"
    }
    
    var weater: String {
        return weather.first?.weatherDescription ?? ""
    }
    
}

// MARK: - Main
struct Main: Codable, Hashable {
    let temp, tempMin, tempMax: Double

    enum CodingKeys: String, CodingKey {
        case temp
        case tempMin = "temp_min"
        case tempMax = "temp_max"
    }
}
