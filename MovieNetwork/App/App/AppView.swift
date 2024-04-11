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
            NavigationStack(path: $navigation.discoverStack) {
                DiscoverView()
                    .navigationTitle("Discover")
                    .navigationBarTitleDisplayMode(.large)
                    .navigationDestination(
                        for: Destination.self,
                        destination: navigation.routeTo
                    )
                    .toolbar { ProfileTrigger() }
            }
            .tag(Tab.discover)
            .tabItem { Image(systemName: "sparkles") }

            NavigationStack(path: $navigation.watchlistStack) {
                WatchlisthView()
                    .navigationTitle("Watchlist")
                    .navigationBarTitleDisplayMode(.large)
                    .navigationDestination(
                        for: Destination.self,
                        destination: navigation.routeTo
                    )
                    .toolbar { ProfileTrigger() }
            }
            .tag(Tab.watchlist)
            .tabItem { Image(systemName: "sparkles.tv.fill") }

            NavigationStack(path: $navigation.feedStack) {
                ZStack {
                    if let user = session.user {
                        FeedView(for: user)
                    } else {
                        AuthRequiredView(message: "You need to sign up to see the feed.")
                    }
                }
                .navigationTitle("Feed")
                .navigationBarTitleDisplayMode(.large)
                .navigationDestination(
                    for: Destination.self,
                    destination: navigation.routeTo
                )
                .toolbar { ProfileTrigger() }
            }
            .tag(Tab.feed)
            .tabItem { Image(systemName: "bolt.fill") }
        }
        .sheet(isPresented: $navigation.showingProfile) {
            NavigationStack(path: $navigation.profileStack) {
                ZStack {
                    if let user = session.user {
                        ProfileView(of: user, for: user)
                    } else {
                        AuthRequiredView(message: "You need to sign up to have a profile.")
                    }
                }
                .navigationTitle("Profile")
                .navigationBarTitleDisplayMode(.inline)
                .navigationDestination(
                    for: Destination.self,
                    destination: navigation.routeTo
                )
            }
        }
        .sheet(isPresented: $navigation.showingMediaSearch) {
            NavigationStack(path: $navigation.mediaSearchStack) {
                MediaSearchView()
                    .navigationTitle("Search")
                    .navigationBarTitleDisplayMode(.inline)
                    .navigationDestination(
                        for: Destination.self,
                        destination: navigation.routeTo
                    )
            }
            .presentationBackground(.thinMaterial)
        }
        .sheet(isPresented: $navigation.showingUserSearch) {
            NavigationStack(path: $navigation.userSearchStack) {
                ZStack {
                    if let user = session.user {
                        UserSearchView(for: user)
                    } else {
                        AuthRequiredView(message: "You need to sign up to search other profiles.")
                    }
                }
                .navigationTitle("Search")
                .navigationBarTitleDisplayMode(.inline)
                .navigationDestination(
                    for: Destination.self,
                    destination: navigation.routeTo
                )
            }
            .presentationBackground(.thinMaterial)
        }
        .onOpenURL(perform: navigation.routeUrl)
        .environmentObject(session)
        .environmentObject(navigation)
    }
}

#Preview {
    AppView()
}
