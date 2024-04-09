//
//  ShowControls.swift
//  MovieNetwork
//
//  Created by Victorien Druon on 09/03/2024.
//

import SwiftUI

struct ShowControls: View {
    @EnvironmentObject var viewModel: ShowViewModel

    var body: some View {
        HStack {
            if viewModel.isInWatchlist {
                Button("Remove", systemImage: "trash") {
                    viewModel.removeShowFromWatchlist()
                }
                .buttonStyle(StyledButton(.secondaryOutline, .full))
                .transition(.scale)
            }

            Button(
                viewModel.isInWatchlist ? "Review" : "Add to watchlist",
                systemImage: viewModel.isInWatchlist ? "star.fill" : "plus"
            ) {
                if viewModel.isInWatchlist {
                    viewModel.showingReviewForm = true
                } else {
                    viewModel.addShowToWatchlist()
                }
            }
            .buttonStyle(StyledButton(.primary, .full))
            .contentTransition(.numericText())
        }
        .padding(.horizontal)
        .animation(.bouncy, value: viewModel.isInWatchlist)
        .sensoryFeedback(.success, trigger: viewModel.triggerControlsHaptic)
    }
}

#Preview {
    ShowControls()
        .environmentObject(ShowViewModel(for: sampleMovie.toShow()))
}
