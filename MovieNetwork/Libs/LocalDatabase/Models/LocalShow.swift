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
        self.posterPath = posterPath
        self.backdropPath = backdropPath
    }
}
