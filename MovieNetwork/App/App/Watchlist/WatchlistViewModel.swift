//
//  WatchlistViewModel.swift
//  MovieNetwork
//
//  Created by Victorien Druon on 23/03/2024.
//

import Foundation

@MainActor
final class WatchlistViewModel: ObservableObject {
    @Published var watchlist = [any WatchlistItem]()
    var shows: [Show] {
        watchlist.compactMap { $0.show.toShow() }
    }

    init() {
        getWatchlist()
    }

    func getWatchlist() {
        Task {
            if let user = await RemoteDbManager.shared.currentSession()?.user {
                watchlist = try await RemoteDbManager.shared.getWatchlist(of: user.id)
            } else {
                watchlist = try LocalDbManager.shared.getWatchlist()
            }
        }
    }
}
