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
    var show: LocalShow
    var createdAt: Date
    var updatedAt: Date?
    var rating: Int
    var comment: String?

    init(show: LocalShow, createdAt: Date = .now, updatedAt: Date? = nil, rating: Int, comment: String?) {
        self.show = show
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.rating = rating
        self.comment = comment
    }
}

