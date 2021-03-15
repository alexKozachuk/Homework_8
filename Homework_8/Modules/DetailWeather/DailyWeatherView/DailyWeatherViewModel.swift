//
//  DailyWeatherViewModel.swift
//  Homework_8
//
//  Created by Sasha on 14/03/2021.
//

import Foundation
import SwiftUI

struct DailyWeatherViewModel: Identifiable {
    
    private let item: Daily
    
    init(item: Daily) {
        self.item = item
    }
    
    var id: String {
        return day + month + minTemp + maxTemp
    }
    
    var day: String {
        return dayFormatter.string(from: Date(timeIntervalSince1970: TimeInterval(item.dt)))
    }
    
    var month: String {
        return monthFormatter.string(from: Date(timeIntervalSince1970: TimeInterval(item.dt)))
    }
    
    var minTemp: String {
        return "\(Int(item.temp.min))º"
    }
    
    var maxTemp: String {
        return "\(Int(item.temp.max))º"
    }
    
}

extension DailyWeatherViewModel: Hashable {
    
    static func == (lhs: DailyWeatherViewModel, rhs: DailyWeatherViewModel) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.id)
    }
    
}
