//
//  Network.swift
//  GameHub
//
//  Created by Ivan Rodriguez on 29/8/23.
//

import UIKit.UIImage

final class Network: NetworkData {
    static let shared = Network()
    
    private func getJSON<JSON: Codable>(url: URLRequest, type: JSON.Type) async throws -> JSON {
        let (data, response) = try await URLSession.shared.getData(for: url)
        
        if response.statusCode == 200 {
            do {
                return try JSONDecoder().decode(JSON.self, from: data)
            } catch {
                throw NetworkError.json(error)
            }
        } else {
            throw NetworkError.status(response.statusCode)
        }
    }
    
    func getGames(params: [String: String]) async throws -> ([GameData], String?) {
        var url: URL = .games
        
        params.forEach { (name, value) in
            url.append(queryItems: [URLQueryItem(name: name, value: value)])
        }
    
        let response = try await getJSON(url: .request(url: url), type: GamesAPIModel.self)
        return (response.results, response.next)
    }
    
    func getGameDetail(id: Int) async throws -> GameDetailData {
        let url: URL = .baseURL.appending(path: "games/\(id)").appending(queryItems: [.apiKey])
        
        let response = try await getJSON(url: .request(url: url), type: GameDetailData.self)
        return response
    }
    
    func getGameScreenshots(id: Int) async throws -> [ScreenshotsData] {
        let url: URL = .baseURL.appending(path: "games/\(id)/screenshots").appending(queryItems: [.apiKey])
        
        let response = try await getJSON(url: .request(url: url), type: ScreenshotsAPIModel.self)
        return response.results
    }
    
    
    func loadImage(url: URL) throws -> UIImage? {
        let data = try Data(contentsOf: url)
        return UIImage(data: data)
    }
    
    func getImage(of game: GameData, callback: @escaping (UIImage?) -> Void) {
        if let image = getImage(name: game.backgroundImage) {
            callback(image)
        } else {
            let path = game.backgroundImage
            Task { @MainActor in
                do {
                    let image = try await getImage(path: path)
                    callback(image)
                } catch {
                    callback(nil)
                }
            }
        }
    }
    
    func getImage(name: String?) -> UIImage? {
        guard let name, let url = URL(string: name) else { return nil }
        let fileName = url.lastPathComponent
        
        let docPath = URL.cachesDirectory.appending(path: fileName)
        if let image = UIImage(named: fileName) {
            return image
        } else if FileManager.default.fileExists(atPath: docPath.path()) {
            return (try? loadImage(url: docPath))
        }
        return nil
    }
    
    func getImage(path: String?) async throws -> UIImage? {
        guard let path, let url = URL(string: path) else { return nil }
        return try await getImage(url: url)
    }
    
    func getImage(url: URL) async throws -> UIImage? {
        let (data, _) = try await URLSession.shared.data(from: url)
        guard let image = UIImage(data: data) else { return nil }
        
        let urlCache = URL.cachesDirectory.appending(path: url.lastPathComponent)
        try image.jpegData(compressionQuality: 0.7)?.write(to: urlCache, options: .atomic)
        
        return image
    }
}
