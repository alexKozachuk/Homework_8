//
//  WeatherError.swift
//  Homework_8
//
//  Created by Sasha on 14/03/2021.
//

import Foundation

enum WeatherError: Error {
    case parsing(description: String)
    case network(description: String)
}
