//
//  Showable.swift
//  MovieNetwork
//
//  Created by Victorien Druon on 24/03/2024.
//

import Foundation

protocol Showable {
    var id: String { get }
    var title: String { get }
    var releaseDate: Date? { get }
    var overview: String? { get }
    var runtime: Int? { get }
    var numberOfSeasons: Int? { get }
    var voteAverage: Double? { get }
    var posterPath: URL? { get }
    var backdropPath: URL? { get }
}

extension Showable {
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
