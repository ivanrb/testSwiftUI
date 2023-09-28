//
//  Interface.swift
//  GameHub
//
//  Created by Ivan Rodriguez on 29/8/23.
//

import Foundation

extension URLQueryItem {
    static let apiKey = URLQueryItem(name: "key", value: "c542e67aec3a4340908f9de9e86038af")
}

extension URL {
    static let baseURL = URL(string: "https://api.rawg.io/api/")!
    
    static let games = baseURL.appending(path: "games").appending(queryItems: [.apiKey])
}

extension URLRequest {
    static func request(url: URL) -> URLRequest {
        var request = URLRequest(url: url)
        
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        return request
    }
    
    var cURL: String {
        guard let url = self.url else { return "" }
        var baseCommand = #"curl "\#(url.absoluteString)""#
        if self.httpMethod == "HEAD" {
            baseCommand += " --head"
        }
        
        var command = [baseCommand]
        if let method = self.httpMethod, method != "GET" && method != "HEAD" {
            command.append("-X \(method)")
        }
        
        if let headers = self.allHTTPHeaderFields {
            for (key, value) in headers where key != "Cookie" {
                command.append("-H '\(key): \(value)'")
            }
        }
        
        if let data = self.httpBody, let body = String(data: data, encoding: .utf8) {
            command.append("-d '\(body)'")
        }
        
        return command.joined(separator: " \\\n\t")
    }
}
