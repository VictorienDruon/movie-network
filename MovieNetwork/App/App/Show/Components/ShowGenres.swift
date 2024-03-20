//
//  ShowGenres.swift
//  MovieNetwork
//
//  Created by Victorien Druon on 09/03/2024.
//

import SwiftData
import SwiftUI

struct ShowGenres: View {
    @EnvironmentObject var viewModel: ShowViewModel

    var body: some View {
        if let genres = viewModel.show.genres, !genres.isEmpty {
            ScrollView(.horizontal) {
                LazyHStack {
                    ForEach(genres) { genre in
                        Tag(genre.name, size: .small)
                    }
                }
            }
            .contentMargins(.horizontal, 16)
        }
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let modelContext = try! ModelContainer(
        for: LocalWatchlistItem.self, LocalReview.self,
        configurations: config
    ).mainContext

    return ShowGenres()
        .environmentObject(ShowViewModel(for: sampleMovie.toShow(), with: modelContext))
}
