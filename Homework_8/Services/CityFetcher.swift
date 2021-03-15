//
//  CityFetcher.swift
//  Homework_8
//
//  Created by Sasha on 15/03/2021.
//

import Foundation

class CityFetcher {
    
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
}

extension CityFetcher {
    
    func getCities(by names: [String], completion: @escaping (Result<[City], WeatherError>) -> Void) {
        guard names != [] else {
            return
        }

        var cities: [City] = []

        names.forEach {
            getCity(by: $0) { result in

                switch result {
                case .success(let city):
                    cities.append(city)
                case .failure(let error):
                    DispatchQueue.main.async {
                        completion(.failure(error))
                    }
                }

                if cities.count == names.count {
                    DispatchQueue.main.async {
                        completion(.success(cities))
                    }
                }
            }
        }

    }
    
    func getCity(by name: String, completion: @escaping (Result<City, WeatherError>) -> Void) {
        var components = URLComponents()
        components.scheme = OpenWeatherAPI.scheme
        components.host = OpenWeatherAPI.host
        components.path = OpenWeatherAPI.path + "/weather"
        components.queryItems = [
            URLQueryItem(name: "q", value: name),
            URLQueryItem(name: "appid", value: OpenWeatherAPI.key),
            URLQueryItem(name: "mode", value: "json"),
        ]
        
        guard let url = components.url else { return }
        let request = URLRequest(url: url)
        
        session.dataTask(with: request) { (data, response, error) in
            if let data = data {
                if let city = try? JSONDecoder().decode(City.self, from: data) {
                    DispatchQueue.main.async {
                        completion(.success(city))
                    }
                } else {
                    DispatchQueue.main.async {
                        completion(.failure(.parsing(description: "JSON Decode Error")))
                    }
                }
            } else if let error = error  {
                DispatchQueue.main.async {
                    completion(.failure(.network(description: error.localizedDescription)))
                }
            }
        }.resume()
        
    }
    
}
