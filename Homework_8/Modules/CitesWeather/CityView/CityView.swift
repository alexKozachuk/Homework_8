//
//  CityView.swift
//  Homework_8
//
//  Created by Sasha on 14/03/2021.
//

import SwiftUI

struct CityView: View {
    
    private struct Const {
        static var padding: CGFloat = 10
        static var cellHeight: CGFloat = 60
        static var backgroundColor = Color(red: 2/255, green: 105/255, blue: 164/255)
        static var textColor = Color.white
    }
    
    private let viewModel: CityViewModel
    
    init(viewModel: CityViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        HStack {
            Text("\(viewModel.title)")
                .padding(.leading, Const.padding)
            Spacer()
            Text("\(viewModel.temperature)°")
                .padding(.trailing, Const.padding)
                .font(.title)
        }
        .frame(minHeight: Const.cellHeight)
        .foregroundColor(Const.textColor)
        .background(Const.backgroundColor)
        .cornerRadius(10)
    }
}
