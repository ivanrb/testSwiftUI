//
//  GameHubApp.swift
//  GameHub
//
//  Created by Ivan Rodriguez on 29/8/23.
//

import SwiftUI

@main
struct GameHubApp: App {
    @StateObject var viewModel = GamesViewModel()
    
    var body: some Scene {
        WindowGroup {
            GamesView()
                .environmentObject(viewModel)
        }
    }
}
