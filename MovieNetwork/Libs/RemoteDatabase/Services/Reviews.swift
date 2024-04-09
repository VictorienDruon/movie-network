//
//  Reviews.swift
//  MovieNetwork
//
//  Created by Victorien Druon on 09/04/2024.
//

import Foundation

extension RemoteDbManager {
    @discardableResult
    func createReview(for show: Show, by userId: UUID, rating: Int, comment: String?) async throws -> RemoteReview {
        try await upsertShow(show)
        let review = RemoteReview(
            userId: userId,
            showId: show.key,
            createdAt: .now,
            rating: rating,
            comment: comment
        )
        return try await database
            .from("reviews")
            .insert(review, returning: .representation)
            .single()
            .execute()
            .value
    }
}
