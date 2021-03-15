//
//  CityView.swift
//  Homework_8
//
//  Created by Sasha on 14/03/2021.
//

import SwiftUI

struct CityView: View {
    private let viewModel: CityViewModel
    
    init(viewModel: CityViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        HStack {
            Text("\(viewModel.title)")
            Spacer()
            Text("\(viewModel.temperature)°")
                .font(.title)
        }
    }
}
