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
    var isTypeFiltered: Bool {
        !typeFilters.isEmpty && typeFilters.count != ShowType.allCases.count
    }

    @Published var trendingShows: [Show]?
    var filteredTrendingShows: [Show]? {
        trendingShows?.filterByGenre(selectedGenre)
    }

    @Published var trendingPeople: [Person]?

    @Published var nowPlayingMovies: [Show]?
    @Published var nowPlayingTvSeries: [Show]?
    var nowPlayingShows: [Show]? {
        filterByType(movies: nowPlayingMovies, tvSeries: nowPlayingTvSeries)?
            .filterByGenre(selectedGenre)
    }

    @Published var upcomingMovies: [Show]?
    @Published var upcomingTvSeries: [Show]?
    var upcomingShows: [Show]? {
        filterByType(movies: upcomingMovies, tvSeries: upcomingTvSeries)?
            .filterByGenre(selectedGenre)
    }

    init() {
        getAll()
    }

    func getAll() {
        Task {
            await withTaskGroup(of: Void.self) { group in
                group.addTask { await self.getTrendingShows() }
                group.addTask { await self.getTrendingPeople() }
                group.addTask { await self.getNowPlayingMovies() }
                group.addTask { await self.getNowPlayingTvSeries() }
                group.addTask { await self.getUpcomingMovies() }
                group.addTask { await self.getUpcomingTvSeries() }
            }
        }
    }

    func getTrendingShows() {
        Task {
            let endpoint: TrendingEndpoint = !isTypeFiltered
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

    func getNowPlayingMovies() {
        Task {
            let dateFormatter = DateFormatter.tmdbDateFormat
            let now = Date.now
            let sixWeeksAgo = Calendar.current.date(byAdding: .weekOfYear, value: -6, to: now)!
            let filters = [
                URLQueryItem(name: "sort_by", value: "popularity.desc"),
                URLQueryItem(name: "with_release_type", value: "3"),
                URLQueryItem(name: "primary_release_date.gte", value: dateFormatter.string(from: sixWeeksAgo)),
                URLQueryItem(name: "primary_release_date.lte", value: dateFormatter.string(from: now))
            ]
            self.nowPlayingMovies = try await TMDbManager.shared.discover(.movies, filters: filters)
        }
    }

    func getNowPlayingTvSeries() {
        Task {
            let dateFormatter = DateFormatter.tmdbDateFormat
            let now = Date.now
            let oneWeekFromNow = Calendar.current.date(byAdding: .weekOfYear, value: 1, to: now)!
            let filters = [
                URLQueryItem(name: "sort_by", value: "popularity.desc"),
                URLQueryItem(name: "without_genres", value: "10763,10764,10766,10767"),
                URLQueryItem(name: "air_date.gte", value: dateFormatter.string(from: now)),
                URLQueryItem(name: "air_date.lte", value: dateFormatter.string(from: oneWeekFromNow))
            ]
            self.nowPlayingTvSeries = try await TMDbManager.shared.discover(.tvSeries, filters: filters)
        }
    }

    func getUpcomingMovies() {
        Task {
            let dateFormatter = DateFormatter.tmdbDateFormat
            let now = Date.now
            let tomorrow = Calendar.current.date(byAdding: .day, value: 1, to: now)!
            let sixMonthsFromNow = Calendar.current.date(byAdding: .month, value: 6, to: now)!
            let filters = [
                URLQueryItem(name: "sort_by", value: "popularity.desc"),
                URLQueryItem(name: "with_release_type", value: "3"),
                URLQueryItem(name: "primary_release_date.gte", value: dateFormatter.string(from: tomorrow)),
                URLQueryItem(name: "primary_release_date.lte", value: dateFormatter.string(from: sixMonthsFromNow))
            ]
            self.upcomingMovies = try await TMDbManager.shared.discover(.movies, filters: filters)
        }
    }

    func getUpcomingTvSeries() {
        Task {
            let dateFormatter = DateFormatter.tmdbDateFormat
            let now = Date.now
            let tomorrow = Calendar.current.date(byAdding: .day, value: 1, to: now)!
            let sixMonthsFromNow = Calendar.current.date(byAdding: .month, value: 6, to: now)!
            let filters = [
                URLQueryItem(name: "sort_by", value: "popularity.desc"),
                URLQueryItem(name: "without_genres", value: "10763,10764,10766,10767"),
                URLQueryItem(name: "first_air_date.gte", value: dateFormatter.string(from: tomorrow)),
                URLQueryItem(name: "first_air_date.lte", value: dateFormatter.string(from: sixMonthsFromNow))
            ]
            self.upcomingTvSeries = try await TMDbManager.shared.discover(.tvSeries, filters: filters)
        }
    }

    private func filterByType(movies: [Show]?, tvSeries: [Show]?) -> [Show]? {
        guard let movies, let tvSeries else {
            return nil
        }

        if !isTypeFiltered {
            return movies + tvSeries
        } else if typeFilters.contains(.movie) {
            return movies
        } else {
            return tvSeries
        }
    }
}
