//
//  ShowLocal.swift
//  MovieNetwork
//
//  Created by Victorien Druon on 18/03/2024.
//

import Foundation
import SwiftData

@Model
final class ShowsRowLocal {
    @Attribute(.unique)
    var id: String

    @Relationship(deleteRule: .cascade, inverse: \WatchlistRowLocal.show)
    var watchlistRow: WatchlistRowLocal?

    init(id: String, watchlistRow: WatchlistRowLocal? = nil) {
        self.id = id
        self.watchlistRow = watchlistRow
    }
}
