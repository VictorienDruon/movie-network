//
//  LocalWatchlistItem.swift
//  MovieNetwork
//
//  Created by Victorien Druon on 20/03/2024.
//

import Foundation
import SwiftData

@Model
final class LocalWatchlistItem: WatchlistItem {
    var addedAt: Date
    var show: LocalShow

    init(show: LocalShow, addedAt: Date = .now) {
        self.show = show
        self.addedAt = addedAt
    }
}
