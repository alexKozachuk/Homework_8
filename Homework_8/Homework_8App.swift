//
//  Homework_8App.swift
//  Homework_8
//
//  Created by Sasha on 14/03/2021.
//

import SwiftUI

@main
struct Homework_8App: App {
    var body: some Scene {
        WindowGroup {
            let weatherFetcher = WeatherFetcher()
            let viewModel = CitiesWheaterViewModel(weatherFetcher: weatherFetcher)
            CitiesWeatherView(viewModel: viewModel)
        }
    }
}
