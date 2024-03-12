//
//  Request.swift
//  MovieNetwork
//
//  Created by Victorien Druon on 03/03/2024.
//

import Foundation

private let BASE_URL = URL(string: "https://api.themoviedb.org/3")!

struct TMDbRequest {
    var request: URLRequest

    init(path: String, queryItems: [URLQueryItem]? = nil) {
        guard let apiKey = ProcessInfo.processInfo.environment["TMDB_ACCESS_TOKEN"] else {
            fatalError("Missing environment variable.")
        }

        request = URLRequest(url: BASE_URL, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "accept")
        request.addValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        request.url?.append(path: path)
        if let queryItems {
            request.url?.append(queryItems: queryItems)
        }
    }

    func fetch<T: Decodable>(_ type: T.Type) async throws -> T {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .formatted(.tmdbDateFormat)

        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            return try decoder.decode(type, from: data)
        } catch {
            throw error
        }
    }
}
