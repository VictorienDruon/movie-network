//
//  DiscoverViewModel.swift
//  MovieNetwork
//
//  Created by Victorien Druon on 29/02/2024.
//

import Foundation

@MainActor
final class DiscoverViewModel: ObservableObject {
    @Published var showTypeFilters: [ShowType] = [.movie, .tvSeries]
    @Published var selectedGenre: GenreInfo? = nil
}
