//
//  SessionManager.swift
//  MovieNetwork
//
//  Created by Victorien Druon on 26/02/2024.
//

import Foundation

@MainActor
final class SessionManager: ObservableObject {
    @Published var isAuthenticated = false

    init() {
        Task {
            await SupabaseManager.shared.authListener { _, session in
                isAuthenticated = session != nil
            }
        }
    }
}
