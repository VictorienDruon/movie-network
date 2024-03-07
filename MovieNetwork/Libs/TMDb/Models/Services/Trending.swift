//
//  Trending.swift
//  MovieNetwork
//
//  Created by Victorien Druon on 04/03/2024.
//

import Foundation

enum TrendingEndpoint: String {
    case all
    case movies = "movie"
    case tvSeries = "tv"
    case people = "person"
}

enum TrendingTimeWindow: String {
    case day, week
}
