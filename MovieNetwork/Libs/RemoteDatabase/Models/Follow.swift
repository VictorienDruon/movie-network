//
//  Follow.swift
//  MovieNetwork
//
//  Created by Victorien Druon on 09/04/2024.
//

import Foundation

struct Follow: Codable {
    var followerId: UUID
    var followedId: UUID
    var createdAt: Date

    private enum CodingKeys: String, CodingKey {
        case followerId = "follower_id"
        case followedId = "followed_id"
        case createdAt = "created_at"
    }
}
