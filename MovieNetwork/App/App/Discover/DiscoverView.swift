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
        NavigationStack(path: $navigation.discoverStack) {
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
            .navigationTitle("Discover")
            .navigationDestination(for: Destination.self, destination: navigation.routeTo)
            .toolbar { ProfileToolbar() }
            .environmentObject(viewModel)
        }
    }
}

#Preview {
    DiscoverView()
        .environmentObject(NavigationManager())
}
