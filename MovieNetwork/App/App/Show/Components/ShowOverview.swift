//
//  ShowOverview.swift
//  MovieNetwork
//
//  Created by Victorien Druon on 20/03/2024.
//

import SwiftData
import SwiftUI

struct ShowOverview: View {
    @EnvironmentObject var viewModel: ShowViewModel

    var body: some View {
        if let overview = viewModel.show.overview, !overview.isEmpty {
            TextBlock(title: "Overview", content: overview)
        }
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let modelContext = try! ModelContainer(
        for: LocalWatchlistItem.self, LocalReview.self,
        configurations: config
    ).mainContext

    return ShowOverview()
        .environmentObject(ShowViewModel(for: sampleMovie.toShow(), with: modelContext))
}
