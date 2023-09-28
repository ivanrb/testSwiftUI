//
//  ScreenshotsAPIModel.swift
//  GameHub
//
//  Created by Ivan Rodriguez on 14/9/23.
//

import Foundation

// MARK: - ScreenshotsAPIModel
struct ScreenshotsAPIModel: Codable {
    let count: Int
    let next, previous: String?
    let results: [ScreenshotsData]
}

// MARK: - ScreenshotsData
struct ScreenshotsData: Codable, Identifiable {
    let id: Int
    let image: String
    let width, height: Int
    let isDeleted: Bool

    enum CodingKeys: String, CodingKey {
        case id, image, width, height
        case isDeleted = "is_deleted"
    }
}
