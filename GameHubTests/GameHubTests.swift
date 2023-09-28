//
//  GameHubTests.swift
//  GameHubTests
//
//  Created by Ivan Rodriguez on 1/9/23.
//

import XCTest
@testable import GameHub

final class GameHubTests: XCTestCase {

    var sut: GamesViewModel!

    override func tearDownWithError() throws {
        sut = nil
    }

    func test_fetchGames() async {
        sut = GamesViewModel(network: NetworkTest())
        await sut.fetchGames()
        
        XCTAssert(!sut.games.isEmpty)
    }
    
    func test_fetchGamesWithError() async {
        sut = GamesViewModel(network: NetworkTestError())
        
        await sut.fetchGames()
        
        XCTAssertTrue(sut.hasError)
    }
    
    func test_fetchGamesDetail() async {
        sut = GamesViewModel(network: NetworkTest())
        await sut.fetchGameDetail(for: 1)
        
        XCTAssert(sut.gameDetail != nil)
    }
    
    func test_fetchGameScreenshots() async {
        sut = GamesViewModel(network: NetworkTest())
        await sut.fetchGameDetail(for: 1)
        let screenshots = await sut.getGameScreenshots()
        
        XCTAssert(!screenshots.isEmpty)
    }
    
    func test_selectOrder() {
        sut = GamesViewModel(network: NetworkTest())
        
        sut.setOrdering(by: .metacritic)
        
        XCTAssertEqual(sut.getSelectedOrder(), .metacritic)
    }
    
    func test_searchGame() {
        sut = GamesViewModel(network: NetworkTest())
        
        sut.searchGame(name: "test")
        
        XCTAssertTrue(sut.games.isEmpty)
    }
    
    func test_clearGames() {
        sut = GamesViewModel(network: NetworkTest())
        
        sut.clearGameList()
        
        XCTAssertTrue(sut.games.isEmpty)
    }
    
    func test_getGamePredominatColor() {
        sut = GamesViewModel(network: NetworkTest())
        
        XCTAssertEqual(sut.getGamePredominatColor(), .clear)
    }
    
    func test_getGameComplementaryColor() {
        sut = GamesViewModel(network: NetworkTest())
        
        XCTAssertEqual(sut.getGameComplementaryColor(), .clear)
    }
}
