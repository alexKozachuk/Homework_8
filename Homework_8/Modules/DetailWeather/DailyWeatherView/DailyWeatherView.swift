//
//  DailyWeatherView.swift
//  Homework_8
//
//  Created by Sasha on 14/03/2021.
//

import SwiftUI

struct DailyWeatherView: View {
    
    private struct Const {
        static var padding: CGFloat = 10
    }
    
    private let viewModel: DailyWeatherViewModel
    
    init(viewModel: DailyWeatherViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        HStack {
            dateView
            Spacer()
            temperatureView
        }
    }
    
}

private extension DailyWeatherView {
    
    var dateView: some View {
        VStack {
            Text(viewModel.day)
            Text(viewModel.month)
        }
        .padding(.leading, Const.padding)
    }
    
    var temperatureView: some View {
        HStack {
            Text(viewModel.minTemp)
            Text(viewModel.maxTemp)
        }
        .padding(.trailing, Const.padding)
    }
    
}
