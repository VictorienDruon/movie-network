//
//  RemoteDbManager.swift
//  MovieNetwork
//
//  Created by Victorien Druon on 26/02/2024.
//

import Foundation
import Supabase

@MainActor
final class RemoteDbManager {
    static let shared = RemoteDbManager()
    private let database: PostgrestClient
    private let auth: AuthClient

    private init() {
        let supabase = SupabaseClient(supabaseURL: Env.supabaseUrl, supabaseKey: Env.supabaseAnonKey)
        database = supabase.database
        auth = supabase.auth
    }
}

// Auth
extension RemoteDbManager {
    func signInWithIdToken(for provider: OpenIDConnectCredentials.Provider, with idToken: String) async throws {
        try await auth.signInWithIdToken(
            credentials: .init(provider: provider, idToken: idToken)
        )
    }

    func signOut() async throws {
        try await auth.signOut()
    }

    func currentSession() async -> Session? {
        do {
            return try await auth.session
        } catch {
            return nil
        }
    }

    func currentUser() async -> User? {
        do {
            return try await auth.user()
        } catch {
            return nil
        }
    }

    func updateUser(from user: UserAttributes) async throws {
        try await auth.update(user: user)
    }

    func authListener(onChange: (AuthChangeEvent, Session?) -> Void) async {
        for await (event, session) in await auth.authStateChanges {
            onChange(event, session)
        }
    }
}

// Watchlists
extension RemoteDbManager {
    func getWatchlistItem(_ showId: String, of userId: UUID) async throws -> RemoteWatchlistItem? {
        return try await database
            .from("watchlists")
            .select()
            .eq("show_id", value: showId)
            .eq("user_id", value: userId)
            .limit(1)
            .single()
            .execute()
            .value
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

// Reviews
extension RemoteDbManager {
    @discardableResult
    func createReview(for show: Show, by userId: UUID, rating: Int, comment: String?) async throws -> RemoteReview {
        try await upsertShow(show)
        let review = RemoteReview(
            userId: userId,
            showId: show.key,
            createdAt: .now,
            rating: rating,
            comment: comment
        )
        return try await database
            .from("reviews")
            .insert(review, returning: .representation)
            .single()
            .execute()
            .value
    }
}

// Shows
extension RemoteDbManager {
    @discardableResult
    func upsertShow(_ show: Show) async throws -> RemoteShow {
        let updatedShow = RemoteShow(
            id: show.key,
            updatedAt: .now,
            title: show.title,
            releaseDate: show.releaseDate,
            overview: show.overview,
            runtime: show.runtime,
            numberOfSeasons: show.numberOfSeasons,
            voteAverage: show.voteAverage,
            posterPath: show.posterPath,
            backdropPath: show.backdropPath
        )
        return try await database
            .from("shows")
            .upsert(updatedShow, returning: .representation)
            .single()
            .execute()
            .value
    }
}
