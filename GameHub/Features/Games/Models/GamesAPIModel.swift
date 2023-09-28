//
//  GamesAPIModel.swift
//  GameHub
//
//  Created by Ivan Rodriguez on 29/8/23.
//

import Foundation

// MARK: - GamesAPIModel
struct GamesAPIModel: Codable {
    let count: Int
    let next: String?
    let previous: String?
    let results: [GameData]
    
}

// MARK: - GameData
struct GameData: Codable, Identifiable {
    let id: Int
    let name: String
    let released: String?
    let backgroundImage: String?
    let rating: Double
    let metacritic: Int?
    let playtime: Int
    
    enum CodingKeys: String, CodingKey {
        case id, name, released
        case backgroundImage = "background_image"
        case rating, metacritic, playtime
    }
}
