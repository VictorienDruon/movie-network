//
//  WatchlistControls.swift
//  MovieNetwork
//
//  Created by Victorien Druon on 09/03/2024.
//

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
    WatchlistControls()
        .environmentObject(ShowViewModel(for: sampleMovie.toShow()))
}
