//
//  RemoteReview.swift
//  MovieNetwork
//
//  Created by Victorien Druon on 20/03/2024.
//

import Foundation

struct RemoteReview: Codable {
    let id: UUID
    let userId: UUID
    let showId: String
    let createdAt: Date
    let updatedAt: Date?
    let rating: Int
    let comment: String?

    init(
        id: UUID = UUID(),
        userId: UUID,
        showId: String,
        createdAt: Date,
        updatedAt: Date? = nil,
        rating: Int,
        comment: String?
    ) {
        self.id = id
        self.userId = userId
        self.showId = showId
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.rating = rating
        self.comment = comment
    }

    private enum CodingKeys: String, CodingKey {
        case id
        case userId = "user_id"
        case showId = "show_id"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case rating
        case comment
    }
}
