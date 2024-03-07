//
//  Media.swift
//  MovieNetwork
//
//  Created by Victorien Druon on 04/03/2024.
//

import Foundation

enum Media: Identifiable, Codable, Equatable, Hashable {
    case movie(Movie)
    case tvSeries(TVSeries)
    case person(Person)

    var id: Int {
        switch self {
        case let .movie(movie):
            movie.id

        case let .tvSeries(tvSeries):
            tvSeries.id

        case let .person(person):
            person.id
        }
    }
}

extension Media {
    func toShow() -> Show? {
        switch self {
        case let .movie(movie): return .movie(movie)
        case let .tvSeries(tVSeries): return .tvSeries(tVSeries)
        default: return nil
        }
    }

    func toPerson() -> Person? {
        switch self {
        case let .person(person): return person
        default: return nil
        }
    }
}

extension [Media] {
    func toShows() -> [Show] {
        self.compactMap { $0.toShow() }
    }

    func toPeople() -> [Person] {
        self.compactMap { $0.toPerson() }
    }
}

extension Media {
    private enum CodingKeys: String, CodingKey {
        case mediaType
    }

    private enum MediaType: String, Codable, Equatable {
        case movie
        case tvSeries = "tv"
        case person
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let mediaType = try container.decode(MediaType.self, forKey: .mediaType)

        switch mediaType {
        case .movie:
            self = try .movie(Movie(from: decoder))

        case .tvSeries:
            self = try .tvSeries(TVSeries(from: decoder))

        case .person:
            self = try .person(Person(from: decoder))
        }
    }

    func encode(to encoder: Encoder) throws {
        var singleContainer = encoder.singleValueContainer()

        switch self {
        case let .movie(movie):
            try singleContainer.encode(movie)

        case let .tvSeries(tvSeries):
            try singleContainer.encode(tvSeries)

        case let .person(person):
            try singleContainer.encode(person)
        }
    }
}
