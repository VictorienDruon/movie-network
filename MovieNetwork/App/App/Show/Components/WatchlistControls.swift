//
//  WatchlistControls.swift
//  MovieNetwork
//
//  Created by Victorien Druon on 09/03/2024.
//

import SwiftData
import SwiftUI

struct WatchlistControls: View {
    @EnvironmentObject var viewModel: ShowViewModel

    var body: some View {
        HStack {
            if viewModel.inWatchlist {
                Button("Remove", systemImage: "trash") {
                    viewModel.removeShowFromWatchlist()
                }
                .buttonStyle(StyledButton(.secondaryOutline, .full))
                .transition(.scale)
            }

            Button(
                viewModel.inWatchlist ? "Review" : "Add to watchlist",
                systemImage: viewModel.inWatchlist ? "star.fill" : "plus"
            ) {
                if viewModel.inWatchlist {
                    viewModel.showingReviewForm = true
                } else {
                    viewModel.addShowToWatchlist()
                }
            }
            .buttonStyle(StyledButton(.primary, .full))
            .contentTransition(.numericText())
        }
        .padding(.horizontal)
        .animation(.bouncy, value: viewModel.inWatchlist)
        .sensoryFeedback(.success, trigger: viewModel.inWatchlist)
        .sheet(isPresented: $viewModel.showingReviewForm) {
            ReviewForm()
        }
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let modelContext = try! ModelContainer(
        for: LocalWatchlistItem.self, LocalReview.self,
        configurations: config
    ).mainContext

    return WatchlistControls()
        .environmentObject(ShowViewModel(for: sampleMovie.toShow(), with: modelContext))
}
