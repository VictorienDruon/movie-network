//
//  LocalDbManager.swift
//  MovieNetwork
//
//  Created by Victorien Druon on 21/03/2024.
//

import Foundation
import SwiftData

@MainActor
final class LocalDbManager {
    static let shared = LocalDbManager()
    private let database: ModelContext

    private init() {
        do {
            let container = try ModelContainer(for: LocalWatchlistItem.self, LocalReview.self)
            database = ModelContext(container)
        } catch {
            fatalError("Failed to create model container.")
        }
    }
}

// Watchlists
extension LocalDbManager {
    func isInWatchlist(_ show: Show) throws -> Bool {
        let descriptor = FetchDescriptor<LocalWatchlistItem>()
        let watchlist = try database.fetch(descriptor)
        return watchlist.contains(where: { $0.showId == show.databaseId })
    }

    func addToWatchlist(_ show: Show) {
        let watchlistShow = LocalWatchlistItem(showId: show.databaseId)
        database.insert(watchlistShow)
    }

    func removeFromWatchlist(_ show: Show) throws {
        let descriptor = FetchDescriptor<LocalWatchlistItem>()
        let watchlist = try database.fetch(descriptor)
        if let watchItem = watchlist.first(where: { $0.showId == show.databaseId }) {
            database.delete(watchItem)
        }
    }
}

// Reviews
extension LocalDbManager {
    func createReview(for show: Show, rating: Int, comment: String?) {
        let review = LocalReview(showId: show.databaseId, rating: rating, comment: comment)
        database.insert(review)
    }
}
