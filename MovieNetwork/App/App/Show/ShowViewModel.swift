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
    @Published var isInWatchlist = false

    @Published var rating: Int?
    @Published var comment = ""

    @Published var showingTrailer = false
    @Published var showingReviewForm = false

    @Published var isDisabled = true

    @Published var triggerControlsHaptic = 0
    @Published var triggerReviewFormHaptic = 0

    var cast: [CastMember]? {
        show.credits?.cast.uniqued()
    }

    var crew: [CrewMember]? {
        show.credits?.crew.uniqued().filterRelevantJobs()
    }

    init(for show: Show) {
        self.show = show
        getAll()
    }

    func getAll() {
        Task {
            await withTaskGroup(of: Void.self) { group in
                group.addTask { await self.getShow() }
                group.addTask { await self.isInUserWatchlist() }
            }
            isDisabled = false
        }
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

    func isInUserWatchlist() {
        Task {
            if let user = await RemoteDbManager.shared.currentSession()?.user {
                isInWatchlist = try await RemoteDbManager.shared.getWatchlistItem(show.key, of: user.id) != nil
            } else {
                isInWatchlist = try LocalDbManager.shared.getWatchlistItem(show.key) != nil
            }
        }
    }

    func addShowToWatchlist() {
        if !isDisabled {
            Task {
                isDisabled = true
                if let user = await RemoteDbManager.shared.currentSession()?.user {
                    try await RemoteDbManager.shared.addToWatchlist(show, for: user.id)
                } else {
                    try LocalDbManager.shared.addToWatchlist(show)
                }
                isInWatchlist = true
                triggerControlsHaptic += 1
                isDisabled = false
            }
        }
    }

    func removeShowFromWatchlist() {
        if !isDisabled {
            Task {
                isDisabled = true
                if let user = await RemoteDbManager.shared.currentSession()?.user {
                    try await RemoteDbManager.shared.removeFromWatchlist(show.key, for: user.id)
                } else {
                    try LocalDbManager.shared.removeFromWatchlist(show.key)
                }
                isInWatchlist = false
                triggerControlsHaptic += 1
                isDisabled = false
            }
        }
    }

    func reviewShow(rating: Int, comment: String? = nil) {
        if !isDisabled {
            Task {
                isDisabled = true
                if let user = await RemoteDbManager.shared.currentSession()?.user {
                    try await RemoteDbManager.shared.createReview(for: show, by: user.id, rating: rating, comment: comment)
                    try await RemoteDbManager.shared.removeFromWatchlist(show.key, for: user.id)
                } else {
                    try LocalDbManager.shared.createReview(for: show, rating: rating, comment: comment)
                    try LocalDbManager.shared.removeFromWatchlist(show.key)
                }
                isInWatchlist = false
                triggerControlsHaptic += 1
                showingReviewForm = false
                refreshReview()
                isDisabled = false
            }
        }
    }

    func refreshReview() {
        rating = nil
        comment = ""
    }
}
