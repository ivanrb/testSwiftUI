//
//  ContentView.swift
//  GameHub
//
//  Created by Ivan Rodriguez on 29/8/23.
//

import SwiftUI

struct GamesView: View {
    @EnvironmentObject var viewModel: GamesViewModel
    
    @State private var isSearchCancelled: Bool = false
    
    @State var showStyle: GameViewStyle = .grid
    @State var showFilter = false
    @State var loadMore = false
    @State var search = ""
    
    var body: some View {
        NavigationView {
            ScrollView {
                if showStyle == .list {
                    GameListView(isLoading: $viewModel.isLoading,
                                 games: $viewModel.games,
                                 loadMore: $loadMore,
                                 canLoadMore: $viewModel.canLoadMore)
                    .padding(.horizontal)
                    .navigationTitle("game_list_title")
                    .toolbar {
                        Button(action: {
                            showFilter.toggle()
                        }) {
                            Image(systemName: "slider.horizontal.3")
                        }
                    }
                } else {
                    GameGridView(isLoading: $viewModel.isLoading,
                                 games: $viewModel.games,
                                 loadMore: $loadMore,
                                 isSearchCancelled: $isSearchCancelled,
                                 canLoadMore: $viewModel.canLoadMore)
                    .padding(.horizontal)
                    .navigationTitle("game_list_title")
                    .toolbar {
                        Button(action: {
                            showFilter.toggle()
                        }) {
                            Image(systemName: "slider.horizontal.3")
                                .foregroundColor(.primary)
                        }
                    }
                }
            }
            .searchable(text: $search,
                         prompt: "search_placeholder")
        }
        .scrollIndicators(.hidden)
        .onSubmit(of: .search, {
            viewModel.searchGame(name: search)
        })
        .onChange(of: isSearchCancelled, perform: { newValue in
            if !newValue {
                viewModel.isLoading = true
                viewModel.clearGameList()
                
                Task {
                    await viewModel.fetchGames()
                }
            }
        })
        .onChange(of: loadMore, perform: { _ in
            loadMore = false
            Task {
                await viewModel.fetchGames()
            }
        })
        .animation(.default, value: showStyle)
        .sheet(isPresented: $showFilter, onDismiss: {
            viewModel.isLoading = true
            viewModel.clearGameList()
            Task {
                await viewModel.fetchGames()
            }
        }) {
            GameFilterView(orderBy: viewModel.getSelectedOrder(),
                           viewStyle: $showStyle)
            .interactiveDismissDisabled()
        }
        .onAppear {
            Task(priority: .high) {
                await viewModel.fetchGames()
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct GamesView_Previews: PreviewProvider {
    static var previews: some View {
        GamesView()
            .environmentObject(GamesViewModel.test)
    }
}
