//
//  WeekWeatherViewModel.swift
//  Homework_8
//
//  Created by Sasha on 15/03/2021.
//

import SwiftUI
import Combine

class WeekWeatherViewModel: ObservableObject {
    
    @Published var city: City
    @Published var dataSource: [DailyWeatherViewModel] = []
    
    private let weatherFetcher: WeatherFetcher
    private var disposables = Set<AnyCancellable>()
    
    init(weatherFetcher: WeatherFetcher,
         city: City) {
        self.city = city
        self.weatherFetcher = weatherFetcher
        
        $city
            .sink(receiveValue: fetchCityForecast(for:))
            .store(in: &disposables)
        
    }
    
    
    func fetchCityForecast(for city: City) {
        
        weatherFetcher.cityForecast(for: city)
            .map { response in
                response.daily
                    .prefix(4)
                    .map(DailyWeatherViewModel.init)
            }
            .prefix(4)
            .map(Array.removeDuplicates)
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { [weak self] value in
                    guard let self = self else { return }
                    switch value {
                    case .failure:
                        self.dataSource = []
                    case .finished:
                        break
                    }
                },
                receiveValue: { [weak self] forecast in
                    guard let self = self else { return }
                    self.dataSource = forecast
                })
            .store(in: &disposables)
    }
    
}
