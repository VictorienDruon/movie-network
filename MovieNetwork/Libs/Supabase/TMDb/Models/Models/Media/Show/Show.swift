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
        case let .tvSeries(tVSeries): tVSeries.name
        }
    }

    var date: Date? {
        switch self {
        case let .movie(movie): movie.releaseDate
        case let .tvSeries(tvSeries): tvSeries.firstAirDate
        }
    }

    var overview: String? {
        switch self {
        case let .movie(movie): movie.overview
        case let .tvSeries(tVSeries): tVSeries.overview
        }
    }

    var popularity: Double? {
        switch self {
        case let .movie(movie): movie.popularity
        case let .tvSeries(tvSeries): tvSeries.popularity
        }
    }

    var posterPath: URL? {
        switch self {
        case let .movie(movie): movie.posterPath
        case let .tvSeries(tVSeries): tVSeries.posterPath
        }
    }

    var backdropPath: URL? {
        switch self {
        case let .movie(movie): movie.backdropPath
        case let .tvSeries(tVSeries): tVSeries.backdropPath
        }
    }
}

extension Show {
    func belongsToGenre(_ genre: GenreInfo) -> Bool {
        switch self {
        case let .movie(movie):
            guard let genreIds = movie.genreIds, let genreId = genre.movieId else {
                return false
            }
            return genreIds.contains(genreId)

        case let .tvSeries(tvSeries):
            guard let genreIds = tvSeries.genreIds, let genreId = genre.tvSeriesId else {
                return false
            }
            return genreIds.contains(genreId)
        }
    }
}

extension [Show] {
    func filterByGenre(_ genre: GenreInfo?) -> [Show] {
        guard let genre else {
            return self
        }

        return self.filter { $0.belongsToGenre(genre) }
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
