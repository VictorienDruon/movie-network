//
//  TVSeries.swift
//  MovieNetwork
//
//  Created by Victorien Druon on 04/03/2024.
//

import Foundation

struct TVSeries: Identifiable, Codable, Equatable, Hashable, Posterable, Backdropable {
    let id: Int
    let name: String
    let tagline: String?
    let originalName: String?
    let originalLanguage: String?
    let overview: String?
    let episodeRunTime: [Int]?
    let numberOfSeasons: Int?
    let numberOfEpisodes: Int?
    let seasons: [TVSeason]?
    let genreIds: [Int]?
    let genres: [Genre]?
    let firstAirDate: Date?
    let originCountry: [String]?
    let posterPath: URL?
    let backdropPath: URL?
    let homepageURL: URL?
    let isInProduction: Bool?
    let languages: [String]?
    let lastAirDate: Date?
    let networks: [Network]?
    let productionCompanies: [ProductionCompany]?
    let status: String?
    let type: String?
    let popularity: Double?
    let voteAverage: Double?
    let voteCount: Int?
    let isAdultOnly: Bool?
    let character: String?
    let job: String?
    let credits: ShowCredits?
    let recommendations: TVSeriesPageableList?
    let videos: VideoCollection?

    init(
        id: Int,
        name: String,
        tagline: String? = nil,
        originalName: String? = nil,
        originalLanguage: String? = nil,
        overview: String? = nil,
        episodeRunTime: [Int]? = nil,
        numberOfSeasons: Int? = nil,
        numberOfEpisodes: Int? = nil,
        seasons: [TVSeason]? = nil,
        genreIds: [Int]? = nil,
        genres: [Genre]? = nil,
        firstAirDate: Date? = nil,
        originCountry: [String]? = nil,
        posterPath: URL? = nil,
        backdropPath: URL? = nil,
        homepageURL: URL? = nil,
        isInProduction: Bool? = nil,
        languages: [String]? = nil,
        lastAirDate: Date? = nil,
        networks: [Network]? = nil,
        productionCompanies: [ProductionCompany]? = nil,
        status: String? = nil,
        type: String? = nil,
        popularity: Double? = nil,
        voteAverage: Double? = nil,
        voteCount: Int? = nil,
        isAdultOnly: Bool? = nil,
        character: String? = nil,
        job: String? = nil,
        credits: ShowCredits? = nil,
        recommendations: TVSeriesPageableList? = nil,
        videos: VideoCollection? = nil
    ) {
        self.id = id
        self.name = name
        self.tagline = tagline
        self.originalName = originalName
        self.originalLanguage = originalLanguage
        self.overview = overview
        self.episodeRunTime = episodeRunTime
        self.numberOfSeasons = numberOfSeasons
        self.numberOfEpisodes = numberOfEpisodes
        self.seasons = seasons
        self.genreIds = genreIds
        self.genres = genres
        self.firstAirDate = firstAirDate
        self.originCountry = originCountry
        self.posterPath = posterPath
        self.backdropPath = backdropPath
        self.homepageURL = homepageURL
        self.isInProduction = isInProduction
        self.languages = languages
        self.lastAirDate = lastAirDate
        self.networks = networks
        self.productionCompanies = productionCompanies
        self.status = status
        self.type = type
        self.popularity = popularity
        self.voteAverage = voteAverage
        self.voteCount = voteCount
        self.isAdultOnly = isAdultOnly
        self.character = character
        self.job = job
        self.credits = credits
        self.recommendations = recommendations
        self.videos = videos
    }
}

extension TVSeries {
    var link: URL {
        URL(string: "\(appScheme)tv/\(id)")!
    }

    var databaseId: String {
        "tv-\(id)"
    }
}

extension TVSeries {
    func toMedia() -> Media {
        return Media.tvSeries(self)
    }

    func toShow() -> Show {
        return Show.tvSeries(self)
    }
    
    func belongsToAnyGenre(_ genreIdList: [Int]) -> Bool {
        guard let genreIds, !genreIdList.isEmpty else {
            return false
        }
        return genreIdList.contains(where: genreIds.contains)
    }
}

extension [TVSeries] {
    func toMedias() -> [Media] {
        return self.map { $0.toMedia() }
    }

    func toShows() -> [Show] {
        return self.map { $0.toShow() }
    }
}

extension TVSeries {
    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case tagline
        case originalName
        case originalLanguage
        case overview
        case episodeRunTime
        case numberOfSeasons
        case numberOfEpisodes
        case seasons
        case genreIds
        case genres
        case originCountry
        case posterPath
        case backdropPath
        case isInProduction = "inProduction"
        case languages
        case lastAirDate
        case networks
        case productionCompanies
        case status
        case type
        case popularity
        case voteAverage
        case voteCount
        case firstAirDate
        case homepageURL = "homepage"
        case isAdultOnly = "adult"
        case character
        case job
        case credits = "aggregateCredits"
        case recommendations
        case videos
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let container2 = try decoder.container(keyedBy: CodingKeys.self)

        self.id = try container.decode(Int.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.tagline = try container.decodeIfPresent(String.self, forKey: .tagline)
        self.originalName = try container.decodeIfPresent(String.self, forKey: .originalName)
        self.originalLanguage = try container.decodeIfPresent(String.self, forKey: .originalLanguage)
        self.overview = try container.decodeIfPresent(String.self, forKey: .overview)
        self.episodeRunTime = try container.decodeIfPresent([Int].self, forKey: .episodeRunTime)
        self.numberOfSeasons = try container.decodeIfPresent(Int.self, forKey: .numberOfSeasons)
        self.numberOfEpisodes = try container.decodeIfPresent(Int.self, forKey: .numberOfEpisodes)
        self.seasons = try container.decodeIfPresent([TVSeason].self, forKey: .seasons)
        self.genreIds = try container.decodeIfPresent([Int].self, forKey: .genreIds)
        self.genres = try container.decodeIfPresent([Genre].self, forKey: .genres)

        // Need to deal with empty strings - date decoding will fail with an empty string
        let firstAirDateString = try container.decodeIfPresent(String.self, forKey: .firstAirDate)
        self.firstAirDate = try {
            guard let firstAirDateString, !firstAirDateString.isEmpty else {
                return nil
            }

            return try container2.decodeIfPresent(Date.self, forKey: .firstAirDate)
        }()

        self.originCountry = try container.decodeIfPresent([String].self, forKey: .originCountry)
        self.posterPath = try container.decodeIfPresent(URL.self, forKey: .posterPath)
        self.backdropPath = try container.decodeIfPresent(URL.self, forKey: .backdropPath)

        // Need to deal with empty strings - URL decoding will fail with an empty string
        let homepageURLString = try container.decodeIfPresent(String.self, forKey: .homepageURL)
        self.homepageURL = try {
            guard let homepageURLString, !homepageURLString.isEmpty else {
                return nil
            }

            return try container2.decodeIfPresent(URL.self, forKey: .homepageURL)
        }()

        self.isInProduction = try container.decodeIfPresent(Bool.self, forKey: .isInProduction)
        self.languages = try container.decodeIfPresent([String].self, forKey: .languages)
        self.lastAirDate = try container.decodeIfPresent(Date.self, forKey: .lastAirDate)
        self.networks = try container.decodeIfPresent([Network].self, forKey: .networks)
        self.productionCompanies = try container.decodeIfPresent([ProductionCompany].self, forKey: .productionCompanies)
        self.status = try container.decodeIfPresent(String.self, forKey: .status)
        self.type = try container.decodeIfPresent(String.self, forKey: .type)
        self.popularity = try container.decodeIfPresent(Double.self, forKey: .popularity)
        self.voteAverage = try container.decodeIfPresent(Double.self, forKey: .voteAverage)
        self.voteCount = try container.decodeIfPresent(Int.self, forKey: .voteCount)
        self.isAdultOnly = try container.decodeIfPresent(Bool.self, forKey: .isAdultOnly)
        self.character = try container.decodeIfPresent(String.self, forKey: .character)
        self.job = try container.decodeIfPresent(String.self, forKey: .job)
        self.credits = try container.decodeIfPresent(ShowCredits.self, forKey: .credits)
        self.recommendations = try container.decodeIfPresent(TVSeriesPageableList.self, forKey: .recommendations)
        self.videos = try container.decodeIfPresent(VideoCollection.self, forKey: .videos)
    }
}
