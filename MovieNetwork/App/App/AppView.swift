//
//  AppView.swift
//  MovieNetwork
//
//  Created by Victorien Druon on 17/02/2024.
//

import SwiftUI

struct AppView: View {
    @StateObject var session = AuthSession()
    @StateObject var navigation = Navigation()

    var body: some View {
        TabView(selection: $navigation.activeTab) {
            DiscoverView()
                .tag(Tab.discover)
                .tabItem { Image(systemName: Tab.discover.icon) }

            WatchlisthView()
                .tag(Tab.watchlist)
                .tabItem { Image(systemName: Tab.watchlist.icon) }

            FeedView()
                .tag(Tab.feed)
                .tabItem { Image(systemName: Tab.feed.icon) }
        }
        .fullScreenCover(isPresented: $navigation.showingProfile) {
            ProfileView()
        }
        .environmentObject(session)
        .environmentObject(navigation)
        .onOpenURL(perform: navigation.handleUrl)
    }
}

#Preview {
    AppView()
}
