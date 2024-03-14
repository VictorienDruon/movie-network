//
//  SearchViewModel.swift
//  MovieNetwork
//
//  Created by Victorien Druon on 13/03/2024.
//

import Foundation

@MainActor
final class SearchViewModel: ObservableObject {
    @Published var query = ""
    @Published var debouncedQuery = ""
    @Published var results: [Media]?

    init() {
        $query
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .assign(to: &$debouncedQuery)
    }

    func search() {
        Task {
            results = try await TMDbManager.shared.search(debouncedQuery)
        }
    }
}
