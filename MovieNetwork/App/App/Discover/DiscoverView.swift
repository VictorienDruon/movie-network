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
                    DiscoverFilters()

                    if !viewModel.trendingShows.isEmpty {
                        Section("Trending") {
                            ShowPosters(shows: viewModel.trendingShows)
                        }
                    }

                    if !viewModel.trendingPeople.isEmpty {
                        Section("Stars") {
                            PersonThumbnails(people: viewModel.trendingPeople)
                        }
                    }

                    if !viewModel.nowPlayingShows.isEmpty {
                        Section("Now Playing") {
                            ShowPosters(shows: viewModel.nowPlayingShows)
                        }
                    }

                    if !viewModel.upcomingShows.isEmpty {
                        Section("Upcoming") {
                            ShowPosters(shows: viewModel.upcomingShows)
                        }
                    }
                }
            }
            .contentMargins(.vertical, 16)
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
