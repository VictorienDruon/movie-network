//
//  WatchlistDestination.swift
//  MovieNetwork
//
//  Created by Victorien Druon on 18/02/2024.
//

import Foundation

typealias WatchlistStack = [WatchlistDestination]

enum WatchlistDestination {
    case movie
    case tvSeries
}
