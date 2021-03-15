//
//  ContentView.swift
//  Homework_8
//
//  Created by Sasha on 14/03/2021.
//

import SwiftUI

struct CitiesWeatherView: View {
    
    @State var showsTextAlert = false
    @State var showsErrorAlert = false
    @ObservedObject var viewModel: CitiesWheaterViewModel
    
    init(viewModel: CitiesWheaterViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationView {
            list
        }
        .alert(isPresented: $showsTextAlert, TextAlert(title: "Add city", action: { text in
            guard let text = text else { return }
            viewModel.appendCity(by: text) { error in
                if error != nil {
                    self.showsErrorAlert = true
                }
            }
        }))
        .alert(isPresented: $showsErrorAlert, content: {
            Alert(title: Text("City not found"))
        })
    }
    
}

private extension CitiesWeatherView {
    
    var list: some View {
        List {
            if viewModel.dataSource.isEmpty {
                emptySection
            } else {
                citiesSection
            }
        }
        .listStyle(GroupedListStyle())
        .navigationBarTitle("Weather", displayMode: .inline)
        .navigationBarItems(trailing:
            addButton
        )
    }
    
    var addButton: some View {
        Button(action: {
            self.showsTextAlert = true
        }, label: {
            Image(systemName: "plus")
        })
    }
    
    var citiesSection: some View {
        Section {
            
            ForEach(viewModel.dataSource) { cityViewModel in
                makeCell(for: cityViewModel)
            }
            
        }
    }
    
    func makeCell(for viewModel: CityViewModel) -> some View {
        NavigationLink( destination: DetailWeatherView(viewModel: viewModel)) {
            CityView(viewModel: viewModel)
        }
    }
    
    var emptySection: some View {
        Section {
            Text("No results")
                .foregroundColor(.gray)
        }
    }
    
}
