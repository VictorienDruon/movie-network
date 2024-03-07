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
                            ShowPostersList(shows: viewModel.filteredTrendingShows)
                        }
                    }
                    
                    if !viewModel.trendingPeople.isEmpty {
                        Section("Stars") {
                            PersonThumbnailsList(people: viewModel.trendingPeople)
                        }
                    }
                }
                .padding(.vertical)
            }
            .scrollIndicators(.hidden)
            .navigationTitle("Discover")
            .toolbar { ProfileToolbar() }
            .environmentObject(viewModel)
        }
    }
}

#Preview {
    DiscoverView()
        .environmentObject(NavigationManager())
}
