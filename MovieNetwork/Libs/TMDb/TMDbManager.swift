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
        case .movies: return try await request.fetch(MoviePageableList.self).results.map { Media.movie($0) }
        case .tvSeries: return try await request.fetch(TVSeriesPageableList.self).results.map { Media.tvSeries($0) }
        case .people: return try await request.fetch(PersonPageableList.self).results.map { Media.person($0) }
        }
    }

    func movie(for id: Int) async throws -> Movie {
        let appendToResponse = URLQueryItem(
            name: "append_to_response",
            value: "credits,recommendations,videos"
        )
        let request = TMDbRequest(path: "/movie/\(id)", queryItems: [appendToResponse])
        return try await request.fetch(Movie.self)
    }
    
    func tvSeries(for id: Int) async throws -> TVSeries {
        let appendToResponse = URLQueryItem(
            name: "append_to_response",
            value: "aggregate_credits,recommendations,videos"
        )
        let request = TMDbRequest(path: "/tv/\(id)", queryItems: [appendToResponse])
        return try await request.fetch(TVSeries.self)
    }
    
    func person(for id: Int) async throws -> Person {
        let appendToResponse = URLQueryItem(
            name: "append_to_response",
            value: "combined_credits"
        )
        let request = TMDbRequest(path: "/person/\(id)", queryItems: [appendToResponse])
        return try await request.fetch(Person.self)
    }
}
