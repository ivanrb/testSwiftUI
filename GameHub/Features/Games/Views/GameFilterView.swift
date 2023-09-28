//
//  GameFilterView.swift
//  GameHub
//
//  Created by Ivan Rodriguez on 1/9/23.
//

import SwiftUI

enum GameViewStyle: String, CaseIterable {
    case grid
    case list
    
    var localizedName: LocalizedStringKey { LocalizedStringKey(rawValue) }
    
    var icon: String {
        switch self {
        case .grid:
            return "square.grid.2x2"
        case .list:
            return "rectangle.grid.1x2"
        }
    }
}

enum GameOrder: String, CaseIterable  {
    case released
    case metacritic
    
    var localizedName: LocalizedStringKey { LocalizedStringKey(rawValue)}
    
    var icon: String {
        switch self {
        case .released:
            return "calendar"
        case .metacritic:
            return "star"
        }
    }
}

struct GameFilterView: View {
    @EnvironmentObject var viewModel: GamesViewModel
    @Environment(\.dismiss) var dismiss
    
    @State private var search: String = ""
    @Binding var gameViewStyle: GameViewStyle
    
    @State private var selectedViewStyle: GameViewStyle
    @State private var selectedOrdering: GameOrder
    @State private var rating: Double = 50
    
    init(orderBy: GameOrder, viewStyle: Binding<GameViewStyle>) {
        _gameViewStyle = viewStyle
        _selectedViewStyle = State(wrappedValue: viewStyle.wrappedValue)
        _selectedOrdering = State(initialValue: orderBy)
    }
    
    var body: some View {
        NavigationView {
            Form {
                Picker("order", selection: $selectedOrdering) {
                    ForEach(GameOrder.allCases, id: \.self) { order in
                        Label(order.localizedName,
                              systemImage: order.icon)
                            .tag(order)
                    }
                }
                .pickerStyle(.inline)

                Picker("view_style", selection: $selectedViewStyle) {
                    ForEach(GameViewStyle.allCases, id: \.self) { style in
                        Label(style.localizedName,
                              systemImage: style.icon)
                        .tag(style)
                    }
                }
                .pickerStyle(.inline)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("save") {
                        gameViewStyle = selectedViewStyle
                        viewModel.setOrdering(by: selectedOrdering)
                        dismiss()
                    }
                }
            }
        }
    }
}

struct GameFilterView_Previews: PreviewProvider {
    static var previews: some View {
        GameFilterView(orderBy: .released, viewStyle: .constant(.grid))
            .environmentObject(GamesViewModel.test)
    }
}
