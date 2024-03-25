//
//  Show.swift
//  MovieNetwork
//
//  Created by Victorien Druon on 04/03/2024.
//

import Foundation

enum Show: Identifiable, Codable, Equatable, Hashable, Posterable, Backdropable {
    case movie(Movie)
    case tvSeries(TVSeries)

    var id: Int {
        switch self {
        case let .movie(movie): movie.id
        case let .tvSeries(tvSeries): tvSeries.id
        }
    }

    var title: String {
        switch self {
        case let .movie(movie): movie.title
        case let .tvSeries(tvSeries): tvSeries.name
        }
    }

    var releaseDate: Date? {
        switch self {
        case let .movie(movie): movie.releaseDate
        case let .tvSeries(tvSeries): tvSeries.firstAirDate
        }
    }

    var overview: String? {
        switch self {
        case let .movie(movie): movie.overview
        case let .tvSeries(tvSeries): tvSeries.overview
        }
    }

    var runtime: Int? {
        switch self {
        case let .movie(movie): movie.runtime
        default: nil
        }
    }

    var numberOfSeasons: Int? {
        switch self {
        case let .tvSeries(tvSeries): tvSeries.numberOfSeasons
        default: nil
        }
    }

    var posterPath: URL? {
        switch self {
        case let .movie(movie): movie.posterPath
        case let .tvSeries(tvSeries): tvSeries.posterPath
        }
    }

    var backdropPath: URL? {
        switch self {
        case let .movie(movie): movie.backdropPath
        case let .tvSeries(tvSeries): tvSeries.backdropPath
        }
    }

    var voteAverage: Double? {
        switch self {
        case let .movie(movie): movie.voteAverage
        case let .tvSeries(tvSeries): tvSeries.voteAverage
        }
    }

    var genreIds: [Int]? {
        switch self {
        case let .movie(movie): movie.genreIds
        case let .tvSeries(tvSeries): tvSeries.genreIds
        }
    }

    var genreIdsString: String? {
        return genres?.map { $0.id }.joined(separator: ",")
    }

    var genres: [Genre]? {
        switch self {
        case let .movie(movie): movie.genres
        case let .tvSeries(tvSeries): tvSeries.genres
        }
    }

    var character: String? {
        switch self {
        case let .movie(movie): movie.character
        case let .tvSeries(tvSeries): tvSeries.character
        }
    }

    var job: String? {
        switch self {
        case let .movie(movie): movie.job
        case let .tvSeries(tvSeries): tvSeries.job
        }
    }

    var credits: ShowCredits? {
        switch self {
        case let .movie(movie): movie.credits
        case let .tvSeries(tvSeries): tvSeries.credits
        }
    }

    var recommendations: [Show]? {
        switch self {
        case let .movie(movie): movie.recommendations?.results.toShows()
        case let .tvSeries(tvSeries): tvSeries.recommendations?.results.toShows()
        }
    }

    var videos: VideoCollection? {
        switch self {
        case let .movie(movie): movie.videos
        case let .tvSeries(tvSeries): tvSeries.videos
        }
    }

    var link: URL {
        switch self {
        case let .movie(movie): movie.link
        case let .tvSeries(tvSeries): tvSeries.link
        }
    }

    var key: String {
        switch self {
        case let .movie(movie): movie.databaseId
        case let .tvSeries(tvSeries): tvSeries.databaseId
        }
    }
}

extension Show {
    func isMovie() -> Bool {
        switch self {
        case .movie: return true
        default: return false
        }
    }

    func isTvSeries() -> Bool {
        switch self {
        case .tvSeries: return true
        default: return false
        }
    }

    func didWorkAs(_ jobs: [String]) -> Bool {
        if let job = self.job {
            return jobs.contains(job)
        } else {
            return false
        }
    }

    func belongsToAnyGenre(_ movieGenreIds: [Int], _ tvGenreIds: [Int]) -> Bool {
        switch self {
        case let .movie(movie):
            return movie.belongsToAnyGenre(movieGenreIds)
        case let .tvSeries(tvSeries):
            return tvSeries.belongsToAnyGenre(tvGenreIds)
        }
    }
}

extension [Show] {
    func filterMovies() -> [Show] {
        self.filter { $0.isMovie() }
    }

    func filterTvSeries() -> [Show] {
        self.filter { $0.isTvSeries() }
    }

    func filterByGenres(_ genres: [GenreInfo]) -> [Show] {
        let movieGenreIds = genres.compactMap { $0.movieId }
        let tvSeriesGenreIds = genres.compactMap { $0.tvId }

        return self.filter { $0.belongsToAnyGenre(movieGenreIds, tvSeriesGenreIds) }
    }

    func filterByJobs(_ jobs: [String]) -> [Show] {
        return self.filter { $0.didWorkAs(jobs) }
    }

    func sortByMostRecentRelease() -> [Show] {
        return self.sorted { show1, show2 -> Bool in
            guard let date1 = show1.releaseDate, let date2 = show2.releaseDate else {
                return show1.releaseDate != nil
            }
            return date1 > date2
        }
    }
}

extension Show {
    private enum CodingKeys: String, CodingKey {
        case mediaType
    }

    private enum MediaType: String, Decodable, Equatable {
        case movie
        case tvSeries = "tv"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let mediaType = try container.decode(MediaType.self, forKey: .mediaType)

        switch mediaType {
        case .movie:
            self = try .movie(Movie(from: decoder))

        case .tvSeries:
            self = try .tvSeries(TVSeries(from: decoder))
        }
    }

    func encode(to encoder: Encoder) throws {
        var singleContainer = encoder.singleValueContainer()

        switch self {
        case let .movie(movie):
            try singleContainer.encode(movie)

        case let .tvSeries(tvSeries):
            try singleContainer.encode(tvSeries)
        }
    }
}
