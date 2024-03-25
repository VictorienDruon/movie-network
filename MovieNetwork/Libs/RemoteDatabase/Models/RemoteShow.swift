//
//  RemoteShow.swift
//  MovieNetwork
//
//  Created by Victorien Druon on 16/03/2024.
//

import Foundation

struct RemoteShow: Codable, Showable {
    let id: String
    let createdAt: Date?
    let updatedAt: Date?
    let title: String
    let releaseDate: Date?
    let overview: String?
    let runtime: Int?
    let numberOfSeasons: Int?
    let voteAverage: Double?
    let genreIds: String?
    let posterPath: URL?
    let backdropPath: URL?

    init(
        id: String,
        createdAt: Date? = nil,
        updatedAt: Date?,
        title: String,
        releaseDate: Date?,
        overview: String?,
        runtime: Int?,
        numberOfSeasons: Int?,
        voteAverage: Double?,
        genreIds: String?,
        posterPath: URL?,
        backdropPath: URL?
    ) {
        self.id = id
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.title = title
        self.releaseDate = releaseDate
        self.overview = overview
        self.runtime = runtime
        self.numberOfSeasons = numberOfSeasons
        self.voteAverage = voteAverage
        self.genreIds = genreIds
        self.posterPath = posterPath
        self.backdropPath = backdropPath
    }

    private enum CodingKeys: String, CodingKey {
        case id
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case title
        case releaseDate = "release_date"
        case overview
        case runtime
        case numberOfSeasons = "number_of_seasons"
        case voteAverage = "vote_average"
        case genreIds = "genre_ids"
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
    }
}

extension RemoteShow {
    func toShow() -> Show? {
        let components = id.components(separatedBy: "-")
        guard
            components.count == 2,
            let type = components.first,
            let showIdString = components.last,
            let showId = Int(showIdString)
        else { return nil }

        switch type {
        case "movie":
            return Show.movie(
                Movie(
                    id: showId,
                    title: title,
                    overview: overview,
                    runtime: runtime,
                    genreIds: extractIntegers(string: genreIds),
                    releaseDate: releaseDate,
                    posterPath: posterPath,
                    backdropPath: backdropPath,
                    voteAverage: voteAverage
                )
            )
        case "tv":
            return Show.tvSeries(
                TVSeries(
                    id: showId,
                    name: title,
                    overview: overview,
                    numberOfSeasons: numberOfSeasons,
                    genreIds: extractIntegers(string: genreIds),
                    firstAirDate: releaseDate,
                    posterPath: posterPath,
                    backdropPath: backdropPath,
                    voteAverage: voteAverage
                )
            )
        default:
            return nil
        }
    }
}
