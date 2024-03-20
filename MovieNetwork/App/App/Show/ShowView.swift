//
//  ShowView.swift
//  MovieNetwork
//
//  Created by Victorien Druon on 07/03/2024.
//

import SwiftData
import SwiftUI

struct ShowView: View {
    @Environment(\.modelContext) var modelContext

    var show: Show

    var body: some View {
        ScrollView {
            LazyVStack(spacing: 32) {
                LazyVStack(alignment: .leading, spacing: 16) {
                    ShowTrailer()
                    ShowHeader()
                    ShowGenres()
                    WatchlistControls()
                }
                NeutralDivider()
                ShowOverview()
                ShowRecommendations()
                ShowCast()
                ShowCrew()
            }
            .padding(.vertical)
        }
        .scrollIndicators(.hidden)
        .navigationTitle(show.title)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar { ShowToolbar() }
        .environmentObject(ShowViewModel(for: show, with: modelContext))
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let modelContainer = try! ModelContainer(
        for: LocalWatchlistItem.self, LocalReview.self,
        configurations: config
    )

    return ShowView(show: sampleMovie.toShow())
        .modelContainer(modelContainer)
}
