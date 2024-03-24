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
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
    }
}
