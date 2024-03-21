//
//  ShowViewModel.swift
//  MovieNetwork
//
//  Created by Victorien Druon on 07/03/2024.
//

import Foundation

@MainActor
final class ShowViewModel: ObservableObject {
    @Published var show: Show
    @Published var inWatchlist = false

    @Published var rating: Int?
    @Published var comment = ""

    @Published var showingTrailer = false
    @Published var showingReviewForm = false

    var cast: [CastMember]? {
        show.credits?.cast.uniqued()
    }

    var crew: [CrewMember]? {
        show.credits?.crew.uniqued().filterRelevantJobs()
    }

    init(for show: Show) {
        self.show = show
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
            if let user = await RemoteDbManager.shared.currentSession()?.user {
                inWatchlist = try await RemoteDbManager.shared.isInWatchlist(show, for: user)
            } else {
                inWatchlist = try LocalDbManager.shared.isInWatchlist(show)
            }
        }
    }

    func addShowToWatchlist() {
        Task {
            if let user = await RemoteDbManager.shared.currentSession()?.user {
                try await RemoteDbManager.shared.addToWatchlist(show, for: user)
            } else {
                LocalDbManager.shared.addToWatchlist(show)
            }
            inWatchlist = true
        }
    }

    func removeShowFromWatchlist() {
        Task {
            if let user = await RemoteDbManager.shared.currentSession()?.user {
                try await RemoteDbManager.shared.removeFromWatchlist(show, for: user)
            } else {
                try LocalDbManager.shared.removeFromWatchlist(show)
            }
            inWatchlist = false
        }
    }

    func reviewShow(rating: Int, comment: String?) {
        Task {
            if let user = await RemoteDbManager.shared.currentSession()?.user {
                try await RemoteDbManager.shared.createReview(for: show, by: user, rating: rating, comment: comment)
            } else {
                LocalDbManager.shared.createReview(for: show, rating: rating, comment: comment)
            }
            removeShowFromWatchlist()
            showingReviewForm = false
        }
    }
}
