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
    var addedAt: Date
    var show: LocalShow?

    init(addedAt: Date = .now) {
        self.addedAt = addedAt
    }
}
