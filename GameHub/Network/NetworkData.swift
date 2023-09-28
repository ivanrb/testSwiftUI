//
//  NetworkData.swift
//  GameHub
//
//  Created by Ivan Rodriguez on 29/8/23.
//

protocol NetworkData {
    func getGames(params: [String: String]) async throws -> ([GameData], String?)
    func getGameDetail(id: Int) async throws -> GameDetailData
    func getGameScreenshots(id: Int) async throws -> [ScreenshotsData]
}
