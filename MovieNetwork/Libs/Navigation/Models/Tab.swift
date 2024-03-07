//
//  Tab.swift
//  MovieNetwork
//
//  Created by Victorien Druon on 18/02/2024.
//

import Foundation
import SwiftUI

enum Tab: CaseIterable, Identifiable {
    case discover, watchlist, feed

    var id: Self {
        return self
    }

    @ViewBuilder var view: some View {
        switch self {
        case .discover:
            DiscoverView()
        case .watchlist:
            WatchlisthView()
        case .feed:
            FeedView()
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
