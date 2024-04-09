//
//  SessionManager.swift
//  MovieNetwork
//
//  Created by Victorien Druon on 26/02/2024.
//

import Auth
import Foundation

@MainActor
final class SessionManager: ObservableObject {
    @Published var session: Session? = nil

    var user: User? {
        session?.user.format()
    }

    var isAuthenticated: Bool {
        session != nil
    }

    init() {
        Task {
            await RemoteDbManager.shared.authListener { _, session in
                self.session = session
            }
        }
    }
}
