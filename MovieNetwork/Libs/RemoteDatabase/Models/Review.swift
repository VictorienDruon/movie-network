//
//  Review.swift
//  MovieNetwork
//
//  Created by Victorien Druon on 20/03/2024.
//

import Foundation

struct Review: Codable {
    let userId: UUID
    let showId: String
    let rating: Int
    let comment: String?
    
    private enum CodingKeys: String, CodingKey {
        case userId = "user_id"
        case showId = "show_id"
        case rating
        case comment
    }
}
