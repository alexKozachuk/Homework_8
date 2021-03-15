//
//  WeekWeatherView.swift
//  Homework_8
//
//  Created by Sasha on 15/03/2021.
//

import SwiftUI

struct WeekWeatherView: View {
    
    @ObservedObject var viewModel: WeekWeatherViewModel
    
    init(viewModel: WeekWeatherViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        list
    }
    
}

private extension WeekWeatherView {
    
    var list: some View {
        List {
            if viewModel.dataSource.isEmpty {
                emptySection
            } else {
                citiesSection
            }
        }
        .listStyle(GroupedListStyle())
    }
    
    var citiesSection: some View {
        Section {
            ForEach(viewModel.dataSource, content: DailyWeatherView.init(viewModel:))
        }
    }
    
    var emptySection: some View {
        Section {
            Text("No results")
                .foregroundColor(.gray)
        }
    }
}
