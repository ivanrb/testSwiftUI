//
//  GameListView.swift
//  GameHub
//
//  Created by Ivan Rodriguez on 31/8/23.
//

import SwiftUI

struct GameListView: View {
    @Environment(\.isSearching) private var isSearching: Bool
    
    @Binding var isLoading: Bool
    @Binding var games: [GameData]
    @Binding var loadMore: Bool
    @Binding var canLoadMore: Bool
    
    var body: some View {
        LazyVStack {
            if isLoading && games.isEmpty {
                ForEach((1...10), id: \.self) { _ in
                    GameCardView(game: .test1)
                        .redacted(reason: .placeholder)
                }
            } else {
                if games.isEmpty {
                    GameCardEmpty()
                } else {
                    ForEach(games) { game in
                        GameCardView(game: game)
                    }
                    if canLoadMore {
                        LoadMoreListElement()
                            .padding()
                            .onAppear {
                                loadMore.toggle()
                            }
                    }
                }
            }
        }
    }
}

struct GameListView_Previews: PreviewProvider {
    static var previews: some View {
        GameListView(isLoading: .constant(false),
                     games: .constant([.test1, .empty, .test2]),
                     loadMore: .constant(true),
                     canLoadMore: .constant(true))
    }
}
