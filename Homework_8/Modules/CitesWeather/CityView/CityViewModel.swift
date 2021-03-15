//
//  CityViewModel.swift
//  Homework_8
//
//  Created by Sasha on 14/03/2021.
//

import Foundation
import SwiftUI

struct CityViewModel: Identifiable {
    
    let item: CurrentWeather
    
    var id: String {
        return "\(item.id)"
    }
    
    var title: String {
        return item.cityName
    }
    
    var temperature: String {
        return item.temp
    }
    
    init(item: CurrentWeather) {
        self.item = item
    }
    
}

extension CityViewModel: Hashable {
    static func == (lhs: CityViewModel, rhs: CityViewModel) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.id)
    }
}
