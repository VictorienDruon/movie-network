//
//  AppView.swift
//  MovieNetwork
//
//  Created by Victorien Druon on 17/02/2024.
//

import SwiftUI

struct AppView: View {
    @StateObject var session = SessionManager()
    @StateObject var navigation = NavigationManager()

    var body: some View {
        TabView(selection: $navigation.activeTab) {
            DiscoverView()
                .tag(AppTab.discover)
                .tabItem { Image(systemName: AppTab.discover.icon) }

            WatchlisthView()
                .tag(AppTab.watchlist)
                .tabItem { Image(systemName: AppTab.watchlist.icon) }

            FeedView()
                .tag(AppTab.feed)
                .tabItem { Image(systemName: AppTab.feed.icon) }
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
