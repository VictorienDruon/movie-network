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

    func signInWithIdToken(for provider: OpenIDConnectCredentials.Provider, with idToken: String) async throws {
        try await supabase.auth.signInWithIdToken(
            credentials: .init(provider: provider, idToken: idToken)
        )
    }

    func updateUser(from user: UserAttributes) async throws {
        try await supabase.auth.update(user: user)
    }

    func signOut() async throws {
        try await supabase.auth.signOut()
    }

    func authListener(onChange: (AuthChangeEvent, Session?) -> Void) async {
        for await (event, session) in await SupabaseManager.shared.supabase.auth.authStateChanges {
            onChange(event, session)
        }
    }
}
