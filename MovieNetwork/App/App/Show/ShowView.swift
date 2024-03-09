//
//  ShowView.swift
//  MovieNetwork
//
//  Created by Victorien Druon on 07/03/2024.
//

import SwiftUI

struct ShowView: View {
    @StateObject private var viewModel: ShowViewModel

    init(for show: Show) {
        _viewModel = StateObject(wrappedValue: ShowViewModel(for: show))
    }

    var body: some View {
        ScrollView {
            LazyVStack(spacing: 32) {
                LazyVStack(alignment: .leading, spacing: 16) {
                    ShowTrailer()
                    ShowHeader()
                    ShowGenres()
                    WatchlistControls()
                }

                Divider()
                    .foregroundStyle(.neutral4)
                    .padding(.horizontal)

                if let overview = viewModel.show.overview, !overview.isEmpty {
                    TextBlock(title: "Overview", content: overview)
                }

                if let recommendations = viewModel.show.recommendations, !recommendations.isEmpty {
                    Section("Recommendations") {
                        ShowPosters(shows: recommendations, variant: .bottomTitle, size: .small)
                    }
                }

                if let cast = viewModel.show.credits?.cast, !cast.isEmpty {
                    Section("Cast") {
                        CastThumbnails(cast: cast)
                    }
                }
            }
            .padding(.vertical)
        }
        .scrollIndicators(.hidden)
        .navigationTitle(viewModel.show.title)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar { ShowToolbar() }
        .environmentObject(viewModel)
    }
}

#Preview {
    NavigationStack {
        ShowView(for: sampleMovie.toShow())
    }
}
