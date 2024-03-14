//
//  WatchlisthView.swift
//  MovieNetwork
//
//  Created by Victorien Druon on 18/02/2024.
//

import SwiftUI

struct WatchlisthView: View {
    var body: some View {
        Title3("Watchlist")
    }
}

#Preview {
    @StateObject var navigation = NavigationManager()

    return
        TabView {
            NavigationStack(path: $navigation.watchlistStack) {
                Tab.watchlist.view
                    .navigationTitle(Tab.watchlist.name)
                    .navigationBarTitleDisplayMode(.large)
                    .navigationDestination(for: Destination.self, destination: navigation.routeTo)
                    .toolbar { ProfileTrigger() }
            }
            .tag(Tab.watchlist)
            .tabItem { Image(systemName: Tab.watchlist.icon) }
        }
}
