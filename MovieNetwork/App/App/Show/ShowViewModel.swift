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
    @Published var showingTrailer = false

    init(for show: Show) {
        self.show = show
        getShow()
    }

    func getShow() {
        Task {
            switch show {
            case let .movie(movie):
                show = try await TMDbManager.shared.movie(for: movie.id).toShow()
            case let .tvSeries(tvSeries):
                show = try await TMDbManager.shared.tvSeries(for: tvSeries.id).toShow()
            }
        }
    }
}
