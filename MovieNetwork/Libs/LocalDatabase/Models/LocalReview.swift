//
//  LocalReview.swift
//  MovieNetwork
//
//  Created by Victorien Druon on 20/03/2024.
//

import Foundation
import SwiftData

@Model
final class LocalReview {
    var id: UUID
    var showId: String
    var rating: Int
    var comment: String?

    init(id: UUID = UUID(), showId: String, rating: Int, comment: String? = nil) {
        self.id = id
        self.showId = showId
        self.rating = rating
        self.comment = comment
    }
}
