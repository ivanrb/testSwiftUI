//
//  GamesViewModel.swift
//  GameHub
//
//  Created by Ivan Rodriguez on 29/8/23.
//

import SwiftUI

final class GamesViewModel: ObservableObject {
    let network: NetworkData
    
    @Published var games: [GameData] = []
    @Published var gameDetail: GameDetailData? = nil
    @Published var isLoading: Bool
    @Published var canLoadMore: Bool = false
    @Published var hasError: Bool = false
    
    private var searchText: String? = nil
    private var orderBy: String
    private var page: String? {
        didSet {
            self.canLoadMore = self.page != nil
        }
    }
    
    init(network: NetworkData = Network.shared) {
        self.network = network
        self.isLoading = true
        self.page = nil
        self.orderBy = GameOrder.released.rawValue
    }
    
    func fetchGames() async {
        do {
            let params = prepareParams()
            let (games, next) = try await network.getGames(params: params)
            
            await MainActor.run {
                self.isLoading = false
                self.setNextPage(next)
                games.forEach { game in
                    if self.games.first(where: ({$0.id == game.id})) == nil {
                        self.games.append(game)
                    }
                }
            }
        } catch let error as NetworkError {
            await MainActor.run {
                self.isLoading = false
                self.hasError = true
                print(error)
            }
        } catch {
            await MainActor.run {
                self.isLoading = false
                self.hasError = true
                print(error.localizedDescription)
            }
        }
    }
    
    func fetchGameDetail(for id: Int) async {
        do {
            let gameDatail = try await network.getGameDetail(id: id)
            
            await MainActor.run {
                self.isLoading = false
                self.gameDetail = gameDatail
            }
        } catch let error as NetworkError {
            await MainActor.run {
                self.isLoading = false
                print(error)
            }
        } catch {
            await MainActor.run {
                self.isLoading = false
                print(error.localizedDescription)
            }
        }
    }
    
    func searchGame(name: String) {
        searchText = name
        page = nil
        self.games.removeAll()
        self.isLoading = true
        
        Task(priority: .background) {
            await fetchGames()
        }
    }
    
    func clearGameList() {
        games.removeAll()
        searchText = nil
        page = nil
    }
    
    func getGamePredominatColor() -> UIColor {
        guard let gameDetail,
              let image = Network.shared.getImage(name: gameDetail.backgroundImage),
              let predominatColor = image.predominantColor else {
            return .black
        }
        return predominatColor
    }
    
    func getGameComplementaryColor() -> UIColor {
        guard let gameDetail,
              let image = Network.shared.getImage(name: gameDetail.backgroundImage),
              let predominatColor = image.predominantColor else {
            return .black
        }
        return predominatColor.complementaryColor 
    }
    
    func getGameScreenshots() async -> [ScreenshotsData] {
        guard let gameDetail else { return [] }
        
        do {
            return try await network.getGameScreenshots(id: gameDetail.id)
        } catch let error as NetworkError {
            print(error)
            return []
        } catch {
            print(error.localizedDescription)
            return []
        }
    }
    
    func setOrdering(by: GameOrder) {
        self.orderBy = by.rawValue
    }
    
    func getSelectedOrder() -> GameOrder {
        return GameOrder(rawValue: orderBy) ?? .released
    }
    
    private func prepareParams() -> [String: String] {
        var params = [String: String]()
        
        params.updateValue("0000-01-01,\(Date().requestFormatted)", forKey: "dates")
        params.updateValue("-\(orderBy)", forKey: "ordering")
        params.updateValue("50,100", forKey: "metacritic")
        
        if let page {
            params.updateValue(page, forKey: "page")
        }
        
        if let searchText {
            params.updateValue(searchText, forKey: "search")
        }
        
        return params
    }
    
    private func setNextPage(_ next: String?) {
        guard let next,
              let components = URLComponents(string: next),
              let queryItems = components.queryItems else {
            self.page = nil
            return
        }
        
        self.page = queryItems.first(where: {$0.name == "page"} )?.value
    }
    
}
