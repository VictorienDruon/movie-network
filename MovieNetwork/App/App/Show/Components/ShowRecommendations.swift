//
//  ShowRecommendations.swift
//  MovieNetwork
//
//  Created by Victorien Druon on 20/03/2024.
//

import SwiftData
import SwiftUI

struct ShowRecommendations: View {
    @EnvironmentObject var viewModel: ShowViewModel

    var body: some View {
        if let recommendations = viewModel.show.recommendations, !recommendations.isEmpty {
            Section("Recommendations") {
                ShowPosters(shows: recommendations, variant: .bottomTitle, size: .small)
            }
        }
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let modelContext = try! ModelContainer(
        for: LocalWatchlistItem.self, LocalReview.self,
        configurations: config
    ).mainContext

    return ShowRecommendations()
        .environmentObject(ShowViewModel(for: sampleMovie.toShow(), with: modelContext))
}
