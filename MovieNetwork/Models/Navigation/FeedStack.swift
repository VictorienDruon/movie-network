//
//  FeedStack.swift
//  MovieNetwork
//
//  Created by Victorien Druon on 18/02/2024.
//

import Foundation

typealias FeedStack = [FeedDestination]

enum FeedDestination {
    case movie
    case tvSeries
}
