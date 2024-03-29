//
//  GameDetailData.swift
//  GameHub
//
//  Created by Ivan Rodriguez on 12/9/23.
//

import Foundation

// MARK: - GameDetailData
struct GameDetailData: Codable {
    let id: Int
    let slug, name, nameOriginal, description: String
    let metacritic: Int?
    let metacriticPlatforms: [MetacriticPlatform]?
    let released: String?
    let tba: Bool?
    let updated: String?
    let backgroundImage, backgroundImageAdditional: String?
    let website: String
    let rating: Double
    let ratingTop: Int
    let added: Int
    let playtime, screenshotsCount, moviesCount, creatorsCount: Int
    let achievementsCount, parentAchievementsCount: Int
    let redditURL, redditName, redditDescription, redditLogo: String
    let redditCount, twitchCount, youtubeCount, reviewsTextCount: Int
    let ratingsCount, suggestionsCount: Int
    let alternativeNames: [String]?
    let metacriticURL: String
    let parentsCount, additionsCount, gameSeriesCount: Int
    let reviewsCount: Int
    let saturatedColor, dominantColor: String
    let parentPlatforms: [ParentPlatform]
    let platforms: [PlatformElement]
    let stores: [Store]
    let developers, genres: [Developer]
    let publishers: [Developer]
    let descriptionRaw: String

    enum CodingKeys: String, CodingKey {
        case id, slug, name
        case nameOriginal = "name_original"
        case description, metacritic
        case metacriticPlatforms = "metacritic_platforms"
        case released, tba, updated
        case backgroundImage = "background_image"
        case backgroundImageAdditional = "background_image_additional"
        case website, rating
        case ratingTop = "rating_top"
        case added
        case playtime
        case screenshotsCount = "screenshots_count"
        case moviesCount = "movies_count"
        case creatorsCount = "creators_count"
        case achievementsCount = "achievements_count"
        case parentAchievementsCount = "parent_achievements_count"
        case redditURL = "reddit_url"
        case redditName = "reddit_name"
        case redditDescription = "reddit_description"
        case redditLogo = "reddit_logo"
        case redditCount = "reddit_count"
        case twitchCount = "twitch_count"
        case youtubeCount = "youtube_count"
        case reviewsTextCount = "reviews_text_count"
        case ratingsCount = "ratings_count"
        case suggestionsCount = "suggestions_count"
        case alternativeNames = "alternative_names"
        case metacriticURL = "metacritic_url"
        case parentsCount = "parents_count"
        case additionsCount = "additions_count"
        case gameSeriesCount = "game_series_count"
        case reviewsCount = "reviews_count"
        case saturatedColor = "saturated_color"
        case dominantColor = "dominant_color"
        case parentPlatforms = "parent_platforms"
        case platforms, stores, developers, genres, publishers
        case descriptionRaw = "description_raw"
    }
}

// MARK: - Developer
struct Developer: Codable {
    let id: Int
    let name, slug: String
    let gamesCount: Int
    let imageBackground: String
    let domain: String?

    enum CodingKeys: String, CodingKey {
        case id, name, slug
        case gamesCount = "games_count"
        case imageBackground = "image_background"
        case domain
    }
}

// MARK: - MetacriticPlatform
struct MetacriticPlatform: Codable {
    let metascore: Int
    let url: String
    let platform: MetacriticPlatformPlatform
}

// MARK: - MetacriticPlatformPlatform
struct MetacriticPlatformPlatform: Codable {
    let platform: Int
    let name, slug: String
}

// MARK: - ParentPlatform
struct ParentPlatform: Codable {
    let platform: ParentPlatformPlatform
}

// MARK: - ParentPlatformPlatform
struct ParentPlatformPlatform: Codable {
    let id: Int
    let name, slug: String
}

// MARK: - PlatformElement
struct PlatformElement: Codable {
    let platform: PlatformPlatform
    let requirements: Requirements

    enum CodingKeys: String, CodingKey {
        case platform
        case requirements
    }
}

// MARK: - PlatformPlatform
struct PlatformPlatform: Codable {
    let id: Int
    let name: String
    let image: String?
    let yearEnd: Int?
    let yearStart: Int?
    let gamesCount: Int
    let imageBackground: String?

    enum CodingKeys: String, CodingKey {
        case id, name, image
        case yearEnd = "year_end"
        case yearStart = "year_start"
        case gamesCount = "games_count"
        case imageBackground = "image_background"
    }
}

// MARK: - Requirements
struct Requirements: Codable {
}

// MARK: - Rating
struct Rating: Codable {
    let id: Int
    let title: String
    let count, percent: Double
}

// MARK: - Store
struct Store: Codable {
    let id: Int
    let url: String
    let store: Developer
}

