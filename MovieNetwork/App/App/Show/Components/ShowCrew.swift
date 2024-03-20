//
//  ShowCrew.swift
//  MovieNetwork
//
//  Created by Victorien Druon on 20/03/2024.
//

import SwiftData
import SwiftUI

struct ShowCrew: View {
    @EnvironmentObject var viewModel: ShowViewModel

    var body: some View {
        if let crew = viewModel.crew, !crew.isEmpty {
            Section("Crew") {
                CrewThumbnails(crew: crew)
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

    return ShowCrew()
        .environmentObject(ShowViewModel(for: sampleMovie.toShow(), with: modelContext))
}
