//
//  MediaSearchViewModel.swift
//  MovieNetwork
//
//  Created by Victorien Druon on 13/03/2024.
//

import Foundation

@MainActor
final class MediaSearchViewModel: ObservableObject {
    @Published var results = [Media]()

    func search(query: String) {
        Task {
            if query.isEmpty {
                results = []
            } else {
                results = try await TMDbManager.shared.search(query)
            }
        }
    }
}
