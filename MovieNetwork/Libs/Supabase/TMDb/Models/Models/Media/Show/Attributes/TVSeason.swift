//
//  TVSeason.swift
//  MovieNetwork
//
//  Created by Victorien Druon on 04/03/2024.
//

import Foundation

struct TVSeason: Identifiable, Codable, Equatable, Hashable {
    let id: Int
    let name: String
    let seasonNumber: Int
    let overview: String?
    let airDate: Date?
    let posterPath: URL?
    let episodes: [TVEpisode]?

    init(
        id: Int,
        name: String,
        seasonNumber: Int,
        overview: String? = nil,
        airDate: Date? = nil,
        posterPath: URL? = nil,
        episodes: [TVEpisode]? = nil
    ) {
        self.id = id
        self.name = name
        self.seasonNumber = seasonNumber
        self.overview = overview
        self.airDate = airDate
        self.posterPath = posterPath
        self.episodes = episodes
    }
}
