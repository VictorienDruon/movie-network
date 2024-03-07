//
//  TVEpisode.swift
//  MovieNetwork
//
//  Created by Victorien Druon on 04/03/2024.
//

import Foundation

struct TVEpisode: Identifiable, Codable, Equatable, Hashable {
    let id: Int
    let name: String
    let episodeNumber: Int
    let seasonNumber: Int
    let overview: String?
    let airDate: Date?
    let productionCode: String?
    let stillPath: URL?
    let crew: [CrewMember]?
    let guestStars: [CastMember]?
    let voteAverage: Double?
    let voteCount: Int?

    init(
        id: Int,
        name: String,
        episodeNumber: Int,
        seasonNumber: Int,
        overview: String? = nil,
        airDate: Date? = nil,
        productionCode: String? = nil,
        stillPath: URL? = nil,
        crew: [CrewMember]? = nil,
        guestStars: [CastMember]? = nil,
        voteAverage: Double? = nil,
        voteCount: Int? = nil
    ) {
        self.id = id
        self.name = name
        self.episodeNumber = episodeNumber
        self.seasonNumber = seasonNumber
        self.overview = overview
        self.airDate = airDate
        self.productionCode = productionCode
        self.stillPath = stillPath
        self.crew = crew
        self.guestStars = guestStars
        self.voteAverage = voteAverage
        self.voteCount = voteCount
    }
}
