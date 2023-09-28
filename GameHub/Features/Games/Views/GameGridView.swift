//
//  GameGridView.swift
//  GameHub
//
//  Created by Ivan Rodriguez on 31/8/23.
//

import SwiftUI

struct GameGridView: View {
    @Environment(\.isSearching) private var isSearching
    
    @Binding var isLoading: Bool
    @Binding var games: [GameData]
    @Binding var loadMore: Bool
    @Binding var isSearchCancelled: Bool
    @Binding var canLoadMore: Bool
    
    var body: some View {
        if isLoading && games.isEmpty {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 150))]) {
                ForEach((1...8), id: \.self) { _ in
                    GameCardView(game: .test1)
                        .redacted(reason: .placeholder)
                }
            }
        } else {
            LazyVStack {
                if games.isEmpty {
                    GameCardEmpty()
                } else {
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 150))]) {
                        ForEach(games) { game in
                            NavigationLink {
                                GameDetailView(gameId: game.id)
                            } label: {
                                GameCardView(game: game, isGridView: true)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                }
                if canLoadMore {
                    LoadMoreListElement()
                        .padding()
                        .onAppear {
                            loadMore = true
                        }
                }
            }
            .onChange(of: isSearching, perform: { newValue in
                isSearchCancelled = newValue
            })
        }
    }
}

struct GameGridView_Previews: PreviewProvider {
    static var previews: some View {
        GameGridView(isLoading: .constant(false),
                     games: .constant([.test1, .test2]),
                     loadMore: .constant(true),
                     isSearchCancelled: .constant(false),
                     canLoadMore: .constant(true))
    }
}
