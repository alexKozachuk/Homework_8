//
//  WeatherFetcher.swift
//  Homework_8
//
//  Created by Sasha on 14/03/2021.
//

import Foundation
import Combine

class WeatherFetcher {
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
}

extension WeatherFetcher {
    
    func citiesForecast(for cities: [City]) -> AnyPublisher<ListWeather, WeatherError> {
        return forecast(with: makeCitiesCurrentWeatherComponents(with: cities))
    }
    
    func cityForecast(for city: City) -> AnyPublisher<WeatherForecast, WeatherError> {
        return forecast(with: makeCityForecastComponents(with: city))
    }
    
    private func forecast<T>(with components: URLComponents) -> AnyPublisher<T, WeatherError> where T: Decodable {
        guard let url = components.url else {
            let error = WeatherError.network(description: "Couldn't create URL")
            return Fail(error: error).eraseToAnyPublisher()
        }
        return session.dataTaskPublisher(for: URLRequest(url: url))
            .mapError { error in
                .network(description: error.localizedDescription)
            }
            .flatMap(maxPublishers: .max(1)) { pair in
                decode(pair.data)
            }
            .eraseToAnyPublisher()
    }
    
}

private extension WeatherFetcher {
    
    func makeCitiesCurrentWeatherComponents(with cities: [City]) -> URLComponents {
        
        var components = URLComponents()
        
        let ids = cities.map{ "\($0.id)" }.joined(separator: ",")
        components.scheme = OpenWeatherAPI.scheme
        components.host = OpenWeatherAPI.host
        components.path = OpenWeatherAPI.path + "/group"
        components.queryItems = [
            URLQueryItem(name: "id", value: ids),
            URLQueryItem(name: "appid", value: OpenWeatherAPI.key),
            URLQueryItem(name: "units", value: "metric"),
            URLQueryItem(name: "mode", value: "json")
        ]
        
        return components
        
    }
    
    func makeCityForecastComponents(with city: City) -> URLComponents {
        
        var components = URLComponents()
        components.scheme = OpenWeatherAPI.scheme
        components.host = OpenWeatherAPI.host
        components.path = OpenWeatherAPI.path + "/onecall"
        components.queryItems = [
            URLQueryItem(name: "lat", value: "\(city.coord.lat)"),
            URLQueryItem(name: "lon", value: "\(city.coord.lon)"),
            URLQueryItem(name: "appid", value: OpenWeatherAPI.key),
            URLQueryItem(name: "units", value: "metric"),
            URLQueryItem(name: "mode", value: "json")
        ]
        
        return components
        
    }
    
}
