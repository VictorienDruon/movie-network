//
//  FeedView.swift
//  MovieNetwork
//
//  Created by Victorien Druon on 18/02/2024.
//

import SwiftUI

struct FeedView: View {
    @EnvironmentObject var session: SessionManager
    @EnvironmentObject var navigation: NavigationManager

    var body: some View {
        if !session.isAuthenticated {
            AuthRequiredView(message: "You need to sign up to access the Feed.")
        }

        else {
            Title3("Feed")
        }
    }
}

#Preview {
    @StateObject var session = SessionManager()
    @StateObject var navigation = NavigationManager()

    return
        TabView {
            NavigationStack(path: $navigation.feedStack) {
                Tab.feed.view
                    .navigationTitle(Tab.feed.name)
                    .navigationBarTitleDisplayMode(.large)
                    .navigationDestination(for: Destination.self, destination: navigation.routeTo)
                    .toolbar { ProfileTrigger() }
            }
            .tag(Tab.feed)
            .tabItem { Image(systemName: Tab.feed.icon) }
        }
        .environmentObject(session)
        .environmentObject(navigation)
}
