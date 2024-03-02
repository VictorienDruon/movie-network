//
//  NavigationManager.swift
//  MovieNetwork
//
//  Created by Victorien Druon on 18/02/2024.
//

import Foundation

@MainActor
final class NavigationManager: ObservableObject {
    @Published var discoverStack = DiscoverStack()
    @Published var watchlistStack = WatchlistStack()
    @Published var feedStack = FeedStack()
    @Published var profileStack = ProfileStack()
    @Published var showingProfile = false
    @Published var activeTab = AppTab.discover {
        didSet {
            if activeTab == oldValue {
                popToRoot(tab: activeTab)
            }
        }
    }

    func popToRoot(tab: AppTab) {
        switch tab {
        case .discover: discoverStack.removeAll()
        case .watchlist: watchlistStack.removeAll()
        case .feed: feedStack.removeAll()
        }
    }

    func handleUrl(url: URL) {
        print(url)
    }
}
