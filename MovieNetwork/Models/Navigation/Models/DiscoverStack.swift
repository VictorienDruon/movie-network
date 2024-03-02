//
//  DiscoverStack.swift
//  MovieNetwork
//
//  Created by Victorien Druon on 18/02/2024.
//

import Foundation

typealias DiscoverStack = [DiscoverDestination]

enum DiscoverDestination {
    case movie
    case tvSeries
    case search
}
