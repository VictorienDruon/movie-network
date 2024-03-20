//
//  ShowCast.swift
//  MovieNetwork
//
//  Created by Victorien Druon on 20/03/2024.
//

import SwiftData
import SwiftUI

struct ShowCast: View {
    @EnvironmentObject var viewModel: ShowViewModel

    var body: some View {
        if let cast = viewModel.cast, !cast.isEmpty {
            Section("Cast") {
                CastThumbnails(cast: cast)
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

    return ShowCast()
        .environmentObject(ShowViewModel(for: sampleMovie.toShow(), with: modelContext))
}
