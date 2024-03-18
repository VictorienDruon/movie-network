//
//  WatchlistControls.swift
//  MovieNetwork
//
//  Created by Victorien Druon on 09/03/2024.
//

import SwiftData
import SwiftUI

struct WatchlistControls: View {
    @EnvironmentObject var session: SessionManager
    @EnvironmentObject var viewModel: ShowViewModel
    @Environment(\.modelContext) var modelContext
    @Query var watchlist: [WatchlistRowLocal]
    @Query var shows: [ShowsRowLocal]
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
        .sensoryFeedback(.success, trigger: inWatchlist)
        .task { isInWatchlist() }
    }

    private func isInWatchlist() {
        Task {
            if let user = session.user {
                inWatchlist = try await SupabaseManager.shared.isInWatchlist(viewModel.show, for: user)
            } else {
                inWatchlist = watchlist.contains(where: { $0.show?.id == viewModel.show.databaseId })
            }
        }
    }

    private func addToWatchlist() {
        Task {
            if let user = session.user {
                try await SupabaseManager.shared.addToWatchlist(viewModel.show, for: user)
            } else {
                let watchlistRow = WatchlistRowLocal()
                let showRow = ShowsRowLocal(
                    id: viewModel.show.databaseId,
                    watchlistRow: watchlistRow
                )
                modelContext.insert(showRow)
            }
            inWatchlist = true
        }
    }

    private func removeFromWatchlist() {
        Task {
            if let user = session.user {
                try await SupabaseManager.shared.removeFromWatchlist(viewModel.show, for: user)
            } else {
                guard
                    let watchlistRow = watchlist.first(where: { $0.show?.id == viewModel.show.databaseId })
                else { return }
                modelContext.delete(watchlistRow)
            }
            inWatchlist = false
        }
    }
}

#Preview {
    WatchlistControls()
        .environmentObject(SessionManager())
        .environmentObject(ShowViewModel(for: sampleMovie.toShow()))
}
