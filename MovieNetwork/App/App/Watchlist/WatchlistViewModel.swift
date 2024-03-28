//
//  WatchlistViewModel.swift
//  MovieNetwork
//
//  Created by Victorien Druon on 23/03/2024.
//

import Foundation

@MainActor
final class WatchlistViewModel: ObservableObject {
    @Published var typeFilters = ShowType.allCases
    @Published var genreFilters = [GenreInfo]()
    @Published var isShuffled = false

    var isTypeFiltered: Bool {
        !typeFilters.isEmpty && typeFilters.count != ShowType.allCases.count
    }

    var isGenreFiltered: Bool {
        !genreFilters.isEmpty
    }

    var isFiltered: Bool {
        isTypeFiltered || isGenreFiltered
    }

    var numberOfFilters: Int {
        (isTypeFiltered ? typeFilters.count : 0) + genreFilters.count
    }

    @Published var watchlist = [Show]()
    @Published var shuffledWatchlist = [Show]()
    var filteredWatchlist: [Show] {
        filterByGenres(filterByType(
            isShuffled ? shuffledWatchlist : watchlist
        ))
    }

    @Published var showingFilters = false

    func getWatchlist() {
        Task {
            if let user = await RemoteDbManager.shared.currentSession()?.user {
                watchlist = try await RemoteDbManager.shared.getWatchlist(of: user.id).compactMap { $0.show.toShow() }
            } else {
                watchlist = try LocalDbManager.shared.getWatchlist().compactMap { $0.show?.toShow() }
            }
            shuffledWatchlist = watchlist.shuffled()
        }
    }

    private func filterByType(_ shows: [Show]) -> [Show] {
        if !isTypeFiltered {
            return shows
        } else if typeFilters.contains(.movie) {
            return shows.filterMovies()
        } else {
            return shows.filterTvSeries()
        }
    }

    private func filterByGenres(_ shows: [Show]) -> [Show] {
        if isGenreFiltered {
            return shows.filterByGenres(genreFilters)
        } else {
            return shows
        }
    }
}
