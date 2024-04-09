//
//  Shows.swift
//  MovieNetwork
//
//  Created by Victorien Druon on 09/04/2024.
//

import Foundation

extension RemoteDbManager {
    @discardableResult
    func upsertShow(_ show: Show) async throws -> RemoteShow {
        let updatedShow = RemoteShow(
            id: show.key,
            updatedAt: .now,
            title: show.title,
            releaseDate: show.releaseDate,
            overview: show.overview,
            runtime: show.runtime,
            numberOfSeasons: show.numberOfSeasons,
            voteAverage: show.voteAverage,
            genreIds: show.genreIdsString,
            posterPath: show.posterPath,
            backdropPath: show.backdropPath
        )
        return try await database
            .from("shows")
            .upsert(updatedShow, returning: .representation)
            .single()
            .execute()
            .value
    }
}
