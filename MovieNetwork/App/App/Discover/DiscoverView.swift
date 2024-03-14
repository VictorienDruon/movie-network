//
//  DiscoverView.swift
//  MovieNetwork
//
//  Created by Victorien Druon on 18/02/2024.
//

import SwiftUI

struct DiscoverView: View {
    @EnvironmentObject var navigation: NavigationManager
    @StateObject var viewModel = DiscoverViewModel()

    var body: some View {
        ZStack(alignment: .bottom) {
            ScrollView {
                LazyVStack(spacing: 24) {
                    DiscoverFiltersControls()

                    if let trendingShows = viewModel.filteredTrendingShows, !trendingShows.isEmpty {
                        Section("Trending") {
                            ShowPosters(shows: trendingShows)
                        }
                    }

                    if let stars = viewModel.trendingPeople, !stars.isEmpty {
                        Section("Stars") {
                            PersonThumbnails(people: stars)
                        }
                    }

                    if let nowPlayingShows = viewModel.nowPlayingShows, !nowPlayingShows.isEmpty {
                        Section("Now Playing") {
                            ShowPosters(shows: nowPlayingShows)
                        }
                    }

                    if let upcomingShows = viewModel.upcomingShows, !upcomingShows.isEmpty {
                        Section("Upcoming") {
                            ShowPosters(shows: upcomingShows)
                        }
                    }
                }
                .padding(.vertical)
            }
            .scrollIndicators(.hidden)
            .environmentObject(viewModel)

            Button("Search", systemImage: "magnifyingglass") {
                navigation.showingSearch = true
            }
            .labelStyle(LabelLayout(.left, .medium))
            .buttonStyle(StyledButton(.secondaryOutline, .medium))
            .padding()
        }
    }
}

#Preview {
    @StateObject var navigation = NavigationManager()

    return
        TabView {
            NavigationStack(path: $navigation.discoverStack) {
                Tab.discover.view
                    .navigationTitle(Tab.discover.name)
                    .navigationBarTitleDisplayMode(.large)
                    .navigationDestination(for: Destination.self, destination: navigation.routeTo)
                    .toolbar { ProfileTrigger() }
            }
            .tag(Tab.discover)
            .tabItem { Image(systemName: Tab.discover.icon) }
        }
        .environmentObject(navigation)
}
