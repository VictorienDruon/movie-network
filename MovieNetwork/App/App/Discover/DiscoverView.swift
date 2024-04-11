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

                    if !viewModel.filteredTrendingShows.isEmpty {
                        HeaderSection("Trending") {
                            ShowPosters(shows: viewModel.filteredTrendingShows)
                        }
                    }

                    if !viewModel.trendingPeople.isEmpty {
                        HeaderSection("Stars") {
                            PersonThumbnails(people: viewModel.trendingPeople)
                        }
                    }

                    if !viewModel.nowPlayingShows.isEmpty {
                        HeaderSection("Now Playing") {
                            ShowPosters(shows: viewModel.nowPlayingShows)
                        }
                    }

                    if !viewModel.upcomingShows.isEmpty {
                        HeaderSection("Upcoming") {
                            ShowPosters(shows: viewModel.upcomingShows)
                        }
                    }
                }
            }
            .contentMargins(.top, 16)
            .contentMargins(.bottom, 96)
            .scrollIndicators(.hidden)
            .environmentObject(viewModel)

            Button("Search", systemImage: "magnifyingglass") {
                navigation.showingMediaSearch = true
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
        }
        .environmentObject(navigation)
}
