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
    func getWatchlistItem(_ showId: String) throws -> LocalWatchlistItem? {
        let descriptor = FetchDescriptor<LocalWatchlistItem>(predicate: #Predicate { $0.show.id == showId })
        return try database.fetch(descriptor).first
    }

    func getWatchlist(order: SortOrder = .reverse) throws -> [LocalWatchlistItem] {
        let addedAtSort = SortDescriptor(\LocalWatchlistItem.addedAt, order: order)
        let descriptor = FetchDescriptor<LocalWatchlistItem>(sortBy: [addedAtSort])
        return try database.fetch(descriptor)
    }

    @discardableResult
    func addToWatchlist(_ show: Show) throws -> LocalWatchlistItem {
        let upsertedShow = try upsertShow(show)
        let watchlistItem = LocalWatchlistItem(show: upsertedShow)
        database.insert(watchlistItem)
        return watchlistItem
    }

    func removeFromWatchlist(_ showId: String) throws {
        if let watchlistItem = try getWatchlistItem(showId) {
            database.delete(watchlistItem)
        }
    }
}

// Reviews
extension LocalDbManager {
    func getReviews() throws -> [LocalReview] {
        let descriptor = FetchDescriptor<LocalReview>()
        return try database.fetch(descriptor)
    }

    func getReviews(for showId: String) throws -> [LocalReview] {
        let descriptor = FetchDescriptor<LocalReview>(predicate: #Predicate { $0.show.id == showId })
        return try database.fetch(descriptor)
    }

    @discardableResult
    func createReview(for show: Show, rating: Int, comment: String?) throws -> LocalReview {
        let upsertedShow = try upsertShow(show)
        let review = LocalReview(show: upsertedShow, rating: rating, comment: comment)
        database.insert(review)
        return review
    }
}

// Shows
extension LocalDbManager {
    func getShow(_ id: String) throws -> LocalShow? {
        let descriptor = FetchDescriptor<LocalShow>(predicate: #Predicate { $0.id == id })
        return try database.fetch(descriptor).first
    }

    func getShows() throws -> [LocalShow] {
        let descriptor = FetchDescriptor<LocalShow>()
        return try database.fetch(descriptor)
    }

    @discardableResult
    func upsertShow(_ show: Show) throws -> LocalShow {
        if let existingShow = try getShow(show.key) {
            existingShow.title = show.title
            existingShow.updatedAt = .now
            existingShow.releaseDate = show.releaseDate
            existingShow.overview = show.overview
            existingShow.runtime = show.runtime
            existingShow.numberOfSeasons = show.numberOfSeasons
            existingShow.voteAverage = show.voteAverage
            existingShow.genreIds = show.genres?.map { $0.id }
            existingShow.posterPath = show.posterPath
            existingShow.backdropPath = show.backdropPath
            return existingShow
        } else {
            return LocalShow(
                showId: show.key,
                createdAt: .now,
                updatedAt: nil,
                title: show.title,
                releaseDate: show.releaseDate,
                overview: show.overview,
                runtime: show.runtime,
                numberOfSeasons: show.numberOfSeasons,
                voteAverage: show.voteAverage,
                genreIds: show.genres?.map { $0.id },
                posterPath: show.posterPath,
                backdropPath: show.backdropPath
            )
        }
    }
}
