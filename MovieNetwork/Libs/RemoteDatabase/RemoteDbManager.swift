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

// Shows
extension RemoteDbManager {
    func upsertShow(_ show: Show) async throws {
        let row = ShowsRow(id: show.databaseId)
        try await database
            .from("shows")
            .upsert(row)
            .execute()
    }
}

// Watchlists
extension RemoteDbManager {
    func isInWatchlist(_ show: Show, for user: User) async throws -> Bool {
        let row: WatchlistItem? = try await database
            .from("watchlists")
            .select()
            .eq("show_id", value: show.databaseId)
            .limit(1)
            .single()
            .execute()
            .value
        return row != nil
    }

    func addToWatchlist(_ show: Show, for user: User) async throws {
        try await upsertShow(show)

        let row = WatchlistItem(userId: user.id, showId: show.databaseId)
        try await database
            .from("watchlists")
            .insert(row)
            .execute()
    }

    func removeFromWatchlist(_ show: Show, for user: User) async throws {
        try await database
            .from("watchlists")
            .delete()
            .eq("show_id", value: show.databaseId)
            .eq("user_id", value: user.id)
            .execute()
    }
}

// Reviews
extension RemoteDbManager {
    func createReview(for show: Show, by user: User, rating: Int, comment: String?) async throws {
        let row = Review(userId: user.id, showId: show.databaseId, rating: rating, comment: comment)
        try await database
            .from("reviews")
            .insert(row)
            .execute()
    }
}
