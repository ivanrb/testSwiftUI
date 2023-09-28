//
//  URLSession+Extension.swift
//  GameHub
//
//  Created by Ivan Rodriguez on 29/8/23.
//

import Foundation

extension URLSession {
    func getData(from url: URL) async throws -> (data: Data, response: HTTPURLResponse) {
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            guard let res = response as? HTTPURLResponse else {
                throw NetworkError.nonHTTP
            }
            return (data, res)
        } catch let error as NetworkError {
            throw error
        } catch {
            throw NetworkError.general(error)
        }
    }
    
    func getData(for request: URLRequest) async throws -> (data: Data, response: HTTPURLResponse) {
        do {
            #if DEBUG
            print("IRB - CURL BEGIN")
            print(request.cURL)
            print("IRB - END CURL")
            #endif
            let (data, response) = try await URLSession.shared.data(for: request)
            guard let res = response as? HTTPURLResponse else {
                throw NetworkError.nonHTTP
            }
            return (data, res)
        } catch let error as NetworkError {
            throw error
        } catch {
            let error = error as NSError
            if error.code == NSURLErrorCancelled {
                throw NetworkError.requestCancel
            }
            throw NetworkError.general(error)
        }
    }
}
