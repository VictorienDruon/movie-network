//
//  UserSearchViewModel.swift
//  MovieNetwork
//
//  Created by Victorien Druon on 11/04/2024.
//

import Foundation

@MainActor
final class UserSearchViewModel: ObservableObject {
    @Published var results = [User]()

    func search(query: String) {
        Task {
            if query.isEmpty {
                results = []
            } else {
                results = try await RemoteDbManager.shared.searchUsers(query)
            }
        }
    }
}
