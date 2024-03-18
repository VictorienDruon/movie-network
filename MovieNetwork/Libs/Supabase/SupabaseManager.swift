//
//  SupabaseManager.swift
//  MovieNetwork
//
//  Created by Victorien Druon on 26/02/2024.
//

import Foundation
import Supabase

@MainActor
final class SupabaseManager {
    static let shared = SupabaseManager()
    private var supabase: SupabaseClient

    private init() {
        guard
            let projectUrl = ProcessInfo.processInfo.environment["SUPABASE_URL"],
            let anonKey = ProcessInfo.processInfo.environment["SUPABASE_ANON_KEY"]
        else { fatalError("Missing environment variable.") }

        supabase = SupabaseClient(supabaseURL: URL(string: projectUrl)!, supabaseKey: anonKey)
    }
}

// Auth
extension SupabaseManager {
    func signInWithIdToken(for provider: OpenIDConnectCredentials.Provider, with idToken: String) async throws {
        try await supabase.auth.signInWithIdToken(
            credentials: .init(provider: provider, idToken: idToken)
        )
    }

    func signOut() async throws {
        try await supabase.auth.signOut()
    }

    func currentUser() async -> User? {
        do {
            return try await supabase.auth.user()
        } catch {
            return nil
        }
    }

    func updateUser(from user: UserAttributes) async throws {
        try await supabase.auth.update(user: user)
    }

    func authListener(onChange: (AuthChangeEvent, Session?) -> Void) async {
        for await (event, session) in await supabase.auth.authStateChanges {
            onChange(event, session)
        }
    }
}

// Shows
extension SupabaseManager {
    func upsertShow(_ show: Show) async throws {
        let row = ShowsRow(id: show.databaseId)
        try await supabase.database
            .from("shows")
            .upsert(row)
            .execute()
    }
}

// Watchlists
extension SupabaseManager {
    func isInWatchlist(_ show: Show, for user: User) async throws -> Bool {
        let row: WatchlistsRow? = try await supabase.database
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

        let row = WatchlistsRow(userId: user.id, showId: show.databaseId)
        try await supabase.database
            .from("watchlists")
            .insert(row)
            .execute()
    }

    func removeFromWatchlist(_ show: Show, for user: User) async throws {
        try await supabase.database
            .from("watchlists")
            .delete()
            .eq("show_id", value: show.databaseId)
            .eq("user_id", value: user.id)
            .execute()
    }
}
