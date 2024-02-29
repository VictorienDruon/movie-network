//
//  Tab.swift
//  MovieNetwork
//
//  Created by Victorien Druon on 18/02/2024.
//

import Foundation

enum Tab {
    case discover
    case watchlist
    case feed

    var name: String {
        switch self {
        case .discover: "Discover"
        case .watchlist: "Watchlist"
        case .feed: "Feed"
        }
    }

    var icon: String {
        switch self {
        case .discover: "sparkles"
        case .watchlist: "sparkles.tv.fill"
        case .feed: "bolt.fill"
        }
    }
}
