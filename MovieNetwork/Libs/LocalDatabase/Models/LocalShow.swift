//
//  LocalShow.swift
//  MovieNetwork
//
//  Created by Victorien Druon on 23/03/2024.
//

import Foundation
import SwiftData

@Model
final class LocalShow: Showable {
    @Attribute(.unique) var id: String

    var createdAt: Date
    var updatedAt: Date?

    var title: String
    var releaseDate: Date?
    var overview: String?
    var runtime: Int?
    var numberOfSeasons: Int?
    var voteAverage: Double?
    var genreIds: [Int]?
    var posterPath: URL?
    var backdropPath: URL?

    @Relationship(deleteRule: .cascade, inverse: \LocalWatchlistItem.show) var watchlistItem: LocalWatchlistItem? = nil
    @Relationship(deleteRule: .cascade, inverse: \LocalReview.show) var reviews = [LocalReview]()

    init(
        showId: String,
        createdAt: Date,
        updatedAt: Date?,
        title: String,
        releaseDate: Date?,
        overview: String?,
        runtime: Int?,
        numberOfSeasons: Int?,
        voteAverage: Double?,
        genreIds: [Int]?,
        posterPath: URL?,
        backdropPath: URL?
    ) {
        self.id = showId
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
}

extension LocalShow {
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
                    genreIds: genreIds,
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
                    genreIds: genreIds,
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
