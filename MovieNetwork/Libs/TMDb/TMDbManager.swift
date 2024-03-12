//
//  TMDbManager.swift
//  MovieNetwork
//
//  Created by Victorien Druon on 29/02/2024.
//

import Foundation

@MainActor
final class TMDbManager {
    static let shared = TMDbManager()
    private init() {}

    func trending(_ endpoint: TrendingEndpoint = .all, for timeWindow: TrendingTimeWindow = .day) async throws -> [Media] {
        let request = TMDbRequest(path: "/trending/\(endpoint.rawValue)/\(timeWindow.rawValue)")
        switch endpoint {
        case .all: return try await request.fetch(MediaPageableList.self).results
        case .movies: return try await request.fetch(MoviePageableList.self).results.toMedias()
        case .tvSeries: return try await request.fetch(TVSeriesPageableList.self).results.toMedias()
        case .people: return try await request.fetch(PersonPageableList.self).results.toMedias()
        }
    }

    func discover(_ endpoint: DiscoverEndpoint, filters: [URLQueryItem]? = nil) async throws -> [Show] {
        let request = TMDbRequest(path: "/discover/\(endpoint.rawValue)", queryItems: filters)
        switch endpoint {
        case .movies: return try await request.fetch(MoviePageableList.self).results.toShows()
        case .tvSeries: return try await request.fetch(TVSeriesPageableList.self).results.toShows()
        }
    }

    func movie(for id: Int, appendToResponse endpoints: [MovieEndpoint]? = nil) async throws -> Movie {
        var queryItems = [URLQueryItem]()
        if let appendToResponse = endpoints?.map({ $0.rawValue }).joined(separator: ",") {
            queryItems.append(URLQueryItem(name: "append_to_response", value: appendToResponse))
        }
        let request = TMDbRequest(path: "/movie/\(id)", queryItems: queryItems)
        return try await request.fetch(Movie.self)
    }

    func tvSeries(for id: Int, appendToResponse endpoints: [TVSeriesEndpoint]? = nil) async throws -> TVSeries {
        var queryItems = [URLQueryItem]()
        if let appendToResponse = endpoints?.map({ $0.rawValue }).joined(separator: ",") {
            queryItems.append(URLQueryItem(name: "append_to_response", value: appendToResponse))
        }
        let request = TMDbRequest(path: "/tv/\(id)", queryItems: queryItems)
        return try await request.fetch(TVSeries.self)
    }

    func person(for id: Int, appendToResponse endpoints: [PersonEndpoint]? = nil) async throws -> Person {
        var queryItems = [URLQueryItem]()
        if let appendToResponse = endpoints?.map({ $0.rawValue }).joined(separator: ",") {
            queryItems.append(URLQueryItem(name: "append_to_response", value: appendToResponse))
        }
        let request = TMDbRequest(path: "/person/\(id)", queryItems: queryItems)
        return try await request.fetch(Person.self)
    }
}
