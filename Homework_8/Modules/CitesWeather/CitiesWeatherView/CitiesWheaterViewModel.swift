//
//  CitiesWheaterViewModel.swift
//  Homework_8
//
//  Created by Sasha on 14/03/2021.
//

import SwiftUI
import Combine

class CitiesWheaterViewModel: ObservableObject {
    
    @Published var cities: [City] = []
    @Published var dataSource: [CityViewModel] = []
    
    private let weatherFetcher: WeatherFetcher
    private var disposables = Set<AnyCancellable>()
    private let cityStorage = CityStorage()
    private let cityFetcher = CityFetcher()
    
    init(weatherFetcher: WeatherFetcher) {
        
        self.weatherFetcher = weatherFetcher
        
        $cities
            .sink(receiveValue: fetchCityWeather(for:))
            .store(in: &disposables)
        
        checkFirstLoad { [weak self] error in
            if let error = error {
                print(error)
            } else {
                self?.cities = self?.cityStorage.getCities() ?? []
            }
        }
        
    }
    
    func appendCity(by name: String, completion: @escaping (Error?) -> Void) {
        
        cityFetcher.getCity(by: name) { [weak self] result in
            switch result {
            case .success(let city):
                self?.cityStorage.append(city)
                self?.cities.append(city)
                completion(nil)
            case .failure(let error):
                completion(error)
            }
        }
        
    }
    

    func deleteCity(by id: Int) {
        cityStorage.delete(by: id)
        cities.removeAll { $0.id == id }
    }
    
    func fetchCityWeather(for cities: [City]) {
        
        weatherFetcher.citiesForecast(for: cities)
            .map { response in
                response.list.map(CityViewModel.init)
            }
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

private extension CitiesWheaterViewModel {
    
    func checkFirstLoad(completion: @escaping (Error?) -> Void) {
        let userDefaults = UserDefaults.standard
        let firstRun = userDefaults.bool(forKey: "First Run")
        guard firstRun == false else {
            cities = cityStorage.getCities()
            return
        }
        
        let cityStringArr = ["Киев", "Днепр", "Запорожье"]
        
        cityFetcher.getCities(by: cityStringArr) { [weak self] result in
            
            switch result {
            case .success(let cities):
                self?.cityStorage.save(cities)
                userDefaults.setValue(true, forKey: "First Run")
                completion(nil)
            case .failure(let error):
                completion(error)
            }
        
        }
    }
    
}
