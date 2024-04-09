//
//  Watchlists.swift
//  MovieNetwork
//
//  Created by Victorien Druon on 09/04/2024.
//

import Foundation

extension RemoteDbManager {
    func getWatchlistItem(_ showId: String, of userId: UUID) async throws -> RemoteWatchlistItem? {
        let watchlist: [RemoteWatchlistItem] = try await database
            .from("watchlists")
            .select()
            .eq("show_id", value: showId)
            .eq("user_id", value: userId)
            .limit(1)
            .execute()
            .value
        return watchlist.first
    }

    func getWatchlist(of userId: UUID, ascending: Bool = false) async throws -> [RemoteWatchlistItemWithShow] {
        return try await database
            .from("watchlists")
            .select("added_at, shows(*)")
            .eq("user_id", value: userId)
            .order("added_at", ascending: ascending)
            .execute()
            .value
    }

    @discardableResult
    func addToWatchlist(_ show: Show, for userId: UUID) async throws -> RemoteWatchlistItem {
        try await upsertShow(show)
        let watchlistItem = RemoteWatchlistItem(
            userId: userId,
            showId: show.key,
            addedAt: .now
        )
        return try await database
            .from("watchlists")
            .insert(watchlistItem, returning: .representation)
            .single()
            .execute()
            .value
    }

    func removeFromWatchlist(_ showId: String, for userId: UUID) async throws {
        try await database
            .from("watchlists")
            .delete()
            .eq("show_id", value: showId)
            .eq("user_id", value: userId)
            .execute()
    }
}
