//
//  DetailWeatherView.swift
//  Homework_8
//
//  Created by Sasha on 15/03/2021.
//

import SwiftUI


struct DetailWeatherView: View {
    
    private struct Const {
        static var cityFontSize: CGFloat = 30
        static var paddingBottom: CGFloat = 10
        static var paddingTop: CGFloat = 10
        static var weatherFontSize: CGFloat = 20
        static var tempFontSize: CGFloat = 60
        static var minMaxTempFontSize: CGFloat = 20
    }
    
    private let viewModel: DetailWeatherViewModel
    
    init(viewModel: CityViewModel) {
        self.viewModel = DetailWeatherViewModel(currentWeather: viewModel.item)
    }
    
    var body: some View {
        detailCurrentWeather
        if let city = viewModel.city {
            weekWeatherView(city: city)
        } else {
            emptySection
        }
    }
    
}

private extension DetailWeatherView {
    
    var detailCurrentWeather: some View {
        VStack {
            Text(viewModel.cityName)
                .font(.system(size: Const.cityFontSize))
                .padding(.bottom, Const.paddingBottom)
                .padding(.top, Const.paddingTop)
            Text(viewModel.weather)
                .font(.system(size: Const.weatherFontSize))
            Text(viewModel.temp)
                .font(.system(size: Const.tempFontSize))
                .padding(.bottom, Const.paddingBottom)
                .padding(.top, Const.paddingTop)
            Text(viewModel.minMaxTemp)
                .font(.system(size: Const.minMaxTempFontSize))
        }
    }
    
    func weekWeatherView(city: City) -> some View {
       
        let viewModel = WeekWeatherViewModel(weatherFetcher: self.viewModel.weatherFetcher, city: city)
        return WeekWeatherView(viewModel: viewModel)
    
    }
    
    var emptySection: some View {
        Section {
            Text("City not found")
                .foregroundColor(.gray)
        }
    }
    
}

