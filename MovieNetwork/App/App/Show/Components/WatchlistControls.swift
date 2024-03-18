//
//  WatchlistControls.swift
//  MovieNetwork
//
//  Created by Victorien Druon on 09/03/2024.
//

import SwiftUI

struct WatchlistControls: View {
    @EnvironmentObject var session: SessionManager
    @EnvironmentObject var viewModel: ShowViewModel
    @State private var inWatchlist = false

    var body: some View {
        HStack {
            if inWatchlist {
                Button("Remove", systemImage: "trash") {
                    removeFromWatchlist()
                }
                .buttonStyle(StyledButton(.secondaryOutline, .full))
                .transition(.scale)
            }

            Button(inWatchlist ? "Review" : "Add to watchlist", systemImage: inWatchlist ? "star.fill" : "plus") {
                if inWatchlist {}
                else {
                    addToWatchlist()
                }
            }
            .buttonStyle(StyledButton(.primary, .full))
            .contentTransition(.numericText())
        }
        .padding(.horizontal)
        .animation(.bouncy, value: inWatchlist)
        .task { isInWatchlist() }
    }

    private func isInWatchlist() {
        Task {
            if let user = session.user {
                inWatchlist = try await SupabaseManager.shared.isInWatchlist(viewModel.show, for: user)
            } else {
                print("No user - should use local storage")
            }
        }
    }

    private func addToWatchlist() {
        Task {
            if let user = session.user {
                try await SupabaseManager.shared.addToWatchlist(viewModel.show, for: user)
                inWatchlist = true
            } else {
                print("No user - should use local storage")
            }
        }
    }

    private func removeFromWatchlist() {
        Task {
            if let user = session.user {
                try await SupabaseManager.shared.removeFromWatchlist(viewModel.show, for: user)
                inWatchlist = false
            } else {
                print("No user - should use local storage")
            }
        }
    }
}

#Preview {
    WatchlistControls()
        .environmentObject(SessionManager())
        .environmentObject(ShowViewModel(for: sampleMovie.toShow()))
}
