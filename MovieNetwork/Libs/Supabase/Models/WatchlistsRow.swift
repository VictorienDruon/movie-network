//
//  WatchlistsRow.swift
//  MovieNetwork
//
//  Created by Victorien Druon on 16/03/2024.
//

import Foundation

struct WatchlistsRow: Codable {
    let userId: UUID
    let showId: String
    
    private enum CodingKeys: String, CodingKey {
        case userId = "user_id"
        case showId = "show_id"
    }
}
