//
//  AuthSession.swift
//  MovieNetwork
//
//  Created by Victorien Druon on 26/02/2024.
//

import Foundation

@MainActor
final class AuthSession: ObservableObject {
    @Published var isAuthenticated = false

    init() {
        Task {
            for await (_, session) in await AuthManager.shared.supabase.auth.authStateChanges {
                isAuthenticated = session != nil
            }
        }
    }
}
