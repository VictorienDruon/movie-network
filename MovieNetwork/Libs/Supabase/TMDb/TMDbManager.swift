//
//  TMDbManager.swift
//  MovieNetwork
//
//  Created by Victorien Druon on 29/02/2024.
//

import Foundation
import TMDb


@MainActor
final class TMDbManager {
    static let shared = TMDbManager()

    private init() {
        guard let apiKey = ProcessInfo.processInfo.environment["TMDB_API_KEY"] else {
            fatalError("Missing environment variable.")
        }

        let config = TMDbConfiguration(apiKey: apiKey)
        TMDbConfiguration.configure(config)
    }
}
