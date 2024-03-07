//
//  DiscoverViewModel.swift
//  MovieNetwork
//
//  Created by Victorien Druon on 29/02/2024.
//

import Foundation

@MainActor
final class DiscoverViewModel: ObservableObject {
    @Published var typeFilters = ShowType.allCases
    @Published var selectedGenre: GenreInfo?

    @Published var trendingShows = [Show]()
    var filteredTrendingShows: [Show] {
        self.trendingShows.filterByGenre(self.selectedGenre)
    }

    @Published var trendingPeople = [Person]()

    init() {
        self.getAll()
    }

    func getAll() {
        Task {
            await withTaskGroup(of: Void.self) { group in
                group.addTask { await self.getTrendingShows() }
                group.addTask { await self.getTrendingPeople() }
            }
        }
    }

    func getTrendingShows() {
        Task {
            let isFiltered = !self.typeFilters.isEmpty && self.typeFilters.count != ShowType.allCases.count
            let endpoint: TrendingEndpoint = !isFiltered
                ? .all
                : self.typeFilters.contains(.movie) ? .movies : .tvSeries
            self.trendingShows = try await TMDbManager.shared.trending(endpoint).toShows()
        }
    }

    func getTrendingPeople() {
        Task {
            self.trendingPeople = try await TMDbManager.shared.trending(.people).toPeople()
        }
    }
}
