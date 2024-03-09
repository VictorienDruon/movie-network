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
        ScrollView {
            LazyVStack(spacing: 24) {
                DiscoverFiltersControls()

                if !viewModel.filteredTrendingShows.isEmpty {
                    Section("Trending") {
                        ShowPosters(shows: viewModel.filteredTrendingShows)
                    }
                }

                if !viewModel.trendingPeople.isEmpty {
                    Section("Stars") {
                        PersonThumbnails(people: viewModel.trendingPeople)
                    }
                }
            }
            .padding(.vertical)
        }
        .scrollIndicators(.hidden)
        .environmentObject(viewModel)
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
