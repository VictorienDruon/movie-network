//
//  LocalWatchlistItem.swift
//  MovieNetwork
//
//  Created by Victorien Druon on 20/03/2024.
//

import Foundation
import SwiftData

@Model
final class LocalWatchlistItem {
    var showId: String
    var addedAt: Date

    init(showId: String, addedAt: Date = .now) {
        self.showId = showId
        self.addedAt = addedAt
    }
}
