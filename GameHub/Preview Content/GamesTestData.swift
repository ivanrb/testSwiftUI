//
//  GamesTestData.swift
//  GameHub
//
//  Created by Ivan Rodriguez on 29/8/23.
//

import Foundation

final class NetworkTest: NetworkData {
    func getGames(params: [String: String]) async throws -> ([GameData], String?) {
        guard let url = Bundle.main.url(forResource: "GamesTest", withExtension: "json") else { return ([], nil) }
        
        let data = try Data(contentsOf: url)
        guard let decoded = try? JSONDecoder().decode(GamesAPIModel.self, from: data) else { return ([], nil) }
        return (decoded.results, "https://api.rawg.io/api/games?key=APIKEY&page=2")
    }
    
    func getGameDetail(id: Int) async throws -> GameDetailData {
        return .test
    }
    
    func getGameScreenshots(id: Int) async throws -> [ScreenshotsData] {
        guard let url = Bundle.main.url(forResource: "ScreenshotsMock", withExtension: "json") else { return [] }
        
        let data = try Data(contentsOf: url)
        guard let decoded = try? JSONDecoder().decode(ScreenshotsAPIModel.self, from: data) else { return [] }
        return decoded.results
    }
}

final class NetworkEmpty: NetworkData {
    func getGames(params: [String: String]) async throws -> ([GameData], String?) {
        return ([], nil)
    }
    
    func getGameDetail(id: Int) async throws -> GameDetailData {
        return .empty
    }
    
    func getGameScreenshots(id: Int) async throws -> [ScreenshotsData] {
        return []
    }
}

final class NetworkTestError: NetworkData {
    func getGames(params: [String: String]) async throws -> ([GameData], String?) {
        throw NetworkError.dataNotValid
    }
    
    func getGameDetail(id: Int) async throws -> GameDetailData {
        throw NetworkError.dataNotValid
    }
    
    func getGameScreenshots(id: Int) async throws -> [ScreenshotsData] {
        throw NetworkError.dataNotValid
    }
}

extension GamesViewModel {
    static let test = GamesViewModel(network: NetworkTest())
    static let empty = GamesViewModel(network: NetworkEmpty())
}

extension GameData {
    static let test1 = GameData(id: 3498,
                               name: "Grand Theft Auto V",
                               released: "2013-09-17",
                               backgroundImage: "https://media.rawg.io/media/games/20a/20aa03a10cda45239fe22d035c0ebe64.jpg",
                               rating: 4.47,
                               metacritic: 92,
                               playtime: 74)
    static let test2 = GameData(id: 3328,
                               name: "The Witcher 3: Wild Hunt",
                               released: "2015-05-18",
                               backgroundImage: "https://media.rawg.io/media/games/618/618c2031a07bbff6b4f611f10b6bcdbc.jpg",
                               rating: 4.66,
                               metacritic: 92,
                               playtime: 45)
    static let empty = GameData(id: -1,
                               name: "",
                               released: "",
                               backgroundImage: "",
                               rating: 0,
                               metacritic: nil,
                               playtime: 0)
}

extension GameDetailData {
    static let test = GameDetailData(
        id: 1,
        slug: "sample-game",
        name: "Sample Game Sample Game Sample Game",
        nameOriginal: "Original Sample Game",
        description: "This is a sample game description.",
        metacritic: 85,
        metacriticPlatforms: [
            MetacriticPlatform(
                metascore: 85,
                url: "https://www.metacritic.com/game/sample-game",
                platform: MetacriticPlatformPlatform(platform: 1, name: "platform", slug: "platform")
            )
        ],
        released: "2023-09-12",
        tba: false,
        updated: "2023-09-12T12:34:56Z",
        backgroundImage: "https://media.rawg.io/media/games/20a/20aa03a10cda45239fe22d035c0ebe64.jpg",
        backgroundImageAdditional: "https://example.com/sample-game-bg-additional.jpg",
        website: "https://www.sample-game.com",
        rating: 4.5,
        ratingTop: 5,
        added: 500,
        playtime: 30,
        screenshotsCount: 10,
        moviesCount: 5,
        creatorsCount: 20,
        achievementsCount: 50,
        parentAchievementsCount: 30,
        redditURL: "https://www.reddit.com/r/sample-game/",
        redditName: "sample-game-reddit",
        redditDescription: "Sample Game Reddit Community",
        redditLogo: "https://example.com/sample-game-reddit-logo.jpg",
        redditCount: 1000,
        twitchCount: 200,
        youtubeCount: 300,
        reviewsTextCount: 150,
        ratingsCount: 2000,
        suggestionsCount: 100,
        alternativeNames: ["Alternate Name 1", "Alternate Name 2"],
        metacriticURL: "https://www.metacritic.com/game/sample-game",
        parentsCount: 10,
        additionsCount: 5,
        gameSeriesCount: 3,
        reviewsCount: 300,
        saturatedColor: "#FF5733",
        dominantColor: "#FF5733",
        parentPlatforms: [
            ParentPlatform(
                platform: ParentPlatformPlatform(
                    id: 1,
                    name: "Sample Parent Platform",
                    slug: "sample-parent-platform"
                )
            )
        ],
        platforms: [
            PlatformElement(
                platform: PlatformPlatform(
                    id: 1,
                    name: "Sample Platform",
                    image: "https://example.com/sample-platform.jpg",
                    yearEnd: 2023,
                    yearStart: 2020,
                    gamesCount: 100,
                    imageBackground: "https://example.com/sample-platform-bg.jpg"
                ),
                requirements: Requirements()
            )
        ],
        stores: [
            Store(
                id: 1,
                url: "https://www.sample-game-store.com",
                store: Developer(
                    id: 1,
                    name: "Sample Store",
                    slug: "sample-store",
                    gamesCount: 50,
                    imageBackground: "https://example.com/sample-store-bg.jpg",
                    domain: "sample-store.com"
                )
            )
        ],
        developers: [
            Developer(
                id: 1,
                name: "Sample Developer",
                slug: "sample-developer",
                gamesCount: 10,
                imageBackground: "https://example.com/sample-developer-bg.jpg",
                domain: "sample-developer.com"
            )
        ],
        genres: [
            Developer(
                id: 1,
                name: "Action",
                slug: "action",
                gamesCount: 1000,
                imageBackground: "https://example.com/genre-action-bg.jpg",
                domain: nil
            )
        ],
        publishers: [
            Developer(
                id: 1,
                name: "Sample Publisher",
                slug: "sample-publisher",
                gamesCount: 5,
                imageBackground: "https://example.com/sample-publisher-bg.jpg",
                domain: "sample-publisher.com"
            )
        ],
        descriptionRaw: "This is a sample game description. This is a sample game description. This is a sample game description. This is a sample game description. This is a sample game description."
    )

    static let empty = GameDetailData(
        id: 0,
        slug: "",
        name: "",
        nameOriginal: "",
        description: "",
        metacritic: nil,
        metacriticPlatforms: nil,
        released: nil,
        tba: nil,
        updated: nil,
        backgroundImage: nil,
        backgroundImageAdditional: nil,
        website: "",
        rating: 0.0,
        ratingTop: 0,
        added: 0,
        playtime: 0,
        screenshotsCount: 0,
        moviesCount: 0,
        creatorsCount: 0,
        achievementsCount: 0,
        parentAchievementsCount: 0,
        redditURL: "",
        redditName: "",
        redditDescription: "",
        redditLogo: "",
        redditCount: 0,
        twitchCount: 0,
        youtubeCount: 0,
        reviewsTextCount: 0,
        ratingsCount: 0,
        suggestionsCount: 0,
        alternativeNames: nil,
        metacriticURL: "",
        parentsCount: 0,
        additionsCount: 0,
        gameSeriesCount: 0,
        reviewsCount: 0,
        saturatedColor: "",
        dominantColor: "",
        parentPlatforms: [],
        platforms: [],
        stores: [],
        developers: [],
        genres: [],
        publishers: [],
        descriptionRaw: ""
    )

}

extension ScreenshotsData {
    static let test = ScreenshotsData(id: 2333717,
                                      image: "https://media.rawg.io/media/screenshots/db6/db625f085ce03f211ea27cf7b7b24b5b.jpg",
                                      width: 1920,
                                      height: 1080,
                                      isDeleted: false)
}
