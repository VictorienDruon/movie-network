//
//  WatchlistRowLocal.swift
//  MovieNetwork
//
//  Created by Victorien Druon on 18/03/2024.
//

import Foundation
import SwiftData

@Model
final class WatchlistRowLocal {
    var show: ShowsRowLocal?

    init(show: ShowsRowLocal? = nil) {
        self.show = show
    }
}
