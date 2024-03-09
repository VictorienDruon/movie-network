//
//  NavigationManager.swift
//  MovieNetwork
//
//  Created by Victorien Druon on 18/02/2024.
//

import Foundation
import SwiftUI

@MainActor
final class NavigationManager: ObservableObject {
    @Published var activeTab = Tab.discover {
        didSet {
            if activeTab == oldValue {
                popToRoot(activeTab)
            }
        }
    }

    @Published var discoverStack = Stack()
    @Published var watchlistStack = Stack()
    @Published var feedStack = Stack()
    @Published var profileStack = Stack()

    @Published var showingProfile = false

    func popToRoot(_ tab: Tab) {
        switch tab {
        case .discover: discoverStack.removeAll()
        case .watchlist: watchlistStack.removeAll()
        case .feed: feedStack.removeAll()
        }
    }

    @ViewBuilder
    func routeTo(destination: Destination) -> some View {
        switch destination {
        case let .show(show):
            ShowView(for: show)
        case let .person(person):
            PersonView(for: person)
        }
    }

    func routeUrl(url: URL) {
        print(url)
    }
}
