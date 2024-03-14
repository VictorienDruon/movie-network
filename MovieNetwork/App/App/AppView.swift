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
            ForEach(Tab.allCases) { tab in
                let path = switch tab {
                case .discover: $navigation.discoverStack
                case .watchlist: $navigation.watchlistStack
                case .feed: $navigation.discoverStack
                }

                NavigationStack(path: path) {
                    tab.view
                        .navigationTitle(tab.name)
                        .navigationBarTitleDisplayMode(.large)
                        .navigationDestination(
                            for: Destination.self,
                            destination: navigation.routeTo
                        )
                        .toolbar { ProfileTrigger() }
                }
                .tag(tab)
                .tabItem { Image(systemName: tab.icon) }
            }
        }
        .sheet(isPresented: $navigation.showingProfile) {
            NavigationStack(path: $navigation.profileStack) {
                ProfileView()
                    .navigationTitle("Profile")
                    .navigationBarTitleDisplayMode(.inline)
                    .navigationDestination(
                        for: Destination.self,
                        destination: navigation.routeTo
                    )
                    .toolbar { ProfileToolbar() }
            }
        }
        .sheet(isPresented: $navigation.showingSearch) {
            NavigationStack(path: $navigation.searchStack) {
                SearchView()
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
