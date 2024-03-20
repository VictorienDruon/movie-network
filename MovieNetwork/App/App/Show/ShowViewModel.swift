//
//  ShowViewModel.swift
//  MovieNetwork
//
//  Created by Victorien Druon on 07/03/2024.
//

import Foundation
import SwiftData

@MainActor
final class ShowViewModel: ObservableObject {
    @Published var show: Show
    @Published var inWatchlist = false

    @Published var rating: Int?
    @Published var comment = ""

    @Published var showingTrailer = false
    @Published var showingReviewForm = false

    var modelContext: ModelContext

    var cast: [CastMember]? {
        show.credits?.cast.uniqued()
    }

    var crew: [CrewMember]? {
        show.credits?.crew.uniqued().filterRelevantJobs()
    }

    init(for show: Show, with modelContext: ModelContext) {
        self.show = show
        self.modelContext = modelContext
        getShow()
        isInWatchlist()
    }

    func getShow() {
        Task {
            switch show {
            case let .movie(movie):
                show = try await TMDbManager.shared.movie(
                    for: movie.id,
                    appendToResponse: [.credits, .recommendations, .videos]
                )
                .toShow()
            case let .tvSeries(tvSeries):
                show = try await TMDbManager.shared.tvSeries(
                    for: tvSeries.id,
                    appendToResponse: [.aggregateCredits, .recommendations, .videos]
                )
                .toShow()
            }
        }
    }

    func isInWatchlist() {
        Task {
            if let user = await SupabaseManager.shared.currentSession()?.user {
                inWatchlist = try await SupabaseManager.shared.isInWatchlist(show, for: user)
            } else {
                let descriptor = FetchDescriptor<LocalWatchlistItem>()
                let watchlist = try modelContext.fetch(descriptor)
                inWatchlist = watchlist.contains(where: { $0.showId == show.databaseId })
            }
        }
    }

    func addShowToWatchlist() {
        Task {
            if let user = await SupabaseManager.shared.currentSession()?.user {
                try await SupabaseManager.shared.addToWatchlist(show, for: user)
            } else {
                let watchlistShow = LocalWatchlistItem(showId: show.databaseId)
                modelContext.insert(watchlistShow)
            }
            inWatchlist = true
        }
    }

    func removeShowFromWatchlist() {
        Task {
            if let user = await SupabaseManager.shared.currentSession()?.user {
                try await SupabaseManager.shared.removeFromWatchlist(show, for: user)
            } else {
                let descriptor = FetchDescriptor<LocalWatchlistItem>()
                let watchlist = try modelContext.fetch(descriptor)
                if let watchItem = watchlist.first(where: { $0.showId == show.databaseId }) {
                    modelContext.delete(watchItem)
                }
            }
            inWatchlist = false
        }
    }

    func reviewShow(rating: Int, comment: String?) {
        Task {
            if let user = await SupabaseManager.shared.currentSession()?.user {
                try await SupabaseManager.shared.createReview(for: show, by: user, rating: rating, comment: comment)
            } else {
                let review = LocalReview(showId: show.databaseId, rating: rating, comment: comment)
                modelContext.insert(review)
            }
            removeShowFromWatchlist()
            showingReviewForm = false
        }
    }
}
