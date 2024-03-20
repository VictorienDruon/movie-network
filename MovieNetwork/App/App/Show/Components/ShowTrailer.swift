//
//  ShowTrailer.swift
//  MovieNetwork
//
//  Created by Victorien Druon on 08/03/2024.
//

import SwiftData
import SwiftUI

struct ShowTrailer: View {
    @EnvironmentObject var viewModel: ShowViewModel

    var body: some View {
        ZStack {
            if let key = viewModel.show.videos?.trailerKey, viewModel.showingTrailer {
                BackdropVideo(key: key, size: .full)
            } else {
                BackdropWithAction(
                    url: viewModel.show.backdropUrl(.w1280),
                    size: .full,
                    disabled: viewModel.show.videos?.trailerKey == nil
                ) {
                    withAnimation {
                        viewModel.showingTrailer = true
                    }
                }
            }
        }
        .transition(.opacity)
        .padding(.horizontal)
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let modelContext = try! ModelContainer(
        for: LocalWatchlistItem.self, LocalReview.self,
        configurations: config
    ).mainContext

    return ShowTrailer()
        .environmentObject(ShowViewModel(for: sampleMovie.toShow(), with: modelContext))
}
