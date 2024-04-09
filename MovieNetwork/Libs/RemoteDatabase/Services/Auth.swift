//
//  Auth.swift
//  MovieNetwork
//
//  Created by Victorien Druon on 09/04/2024.
//

import Auth
import Foundation

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
            return try await auth.user().format()
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
