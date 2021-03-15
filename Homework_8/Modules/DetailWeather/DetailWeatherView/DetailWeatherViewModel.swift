//
//  DetailWeatherViewModel.swift
//  Homework_8
//
//  Created by Sasha on 15/03/2021.
//

import Foundation

class DetailWeatherViewModel {
    
    @Published var currentWeather: CurrentWeather
    @Published var city: City?
    
    let weatherFetcher: WeatherFetcher
    let cityStorage = CityStorage()

    init(weatherFwtcher: WeatherFetcher = WeatherFetcher(),
         currentWeather: CurrentWeather) {
        self.city = cityStorage.getCity(by: currentWeather.id)
        self.weatherFetcher = weatherFwtcher
        self.currentWeather = currentWeather
    }
    
    var cityName: String {
        currentWeather.cityName
    }
    
    var temp: String {
        currentWeather.temp + "º"
    }
    
    var minMaxTemp: String {
        return  "Max: \(currentWeather.maxTemp)º, Min: \(currentWeather.minTemp)º"
    }
    
    var weather: String {
        return currentWeather.weater
    }
    
}
