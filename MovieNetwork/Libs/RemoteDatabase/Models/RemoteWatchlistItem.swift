//
//  WatchlistItem.swift
//  MovieNetwork
//
//  Created by Victorien Druon on 16/03/2024.
//

import Foundation

struct RemoteWatchlistItem: Codable {
    let userId: UUID
    let showId: String
    let addedAt: Date

    private enum CodingKeys: String, CodingKey {
        case userId = "user_id"
        case showId = "show_id"
        case addedAt = "added_at"
    }
}

struct RemoteWatchlistItemWithShow: Decodable {
    let addedAt: Date
    let show: RemoteShow

    private enum CodingKeys: String, CodingKey {
        case addedAt = "added_at"
        case show = "shows"
    }
}
