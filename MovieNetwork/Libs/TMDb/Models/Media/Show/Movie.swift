//
//  Movie.swift
//  MovieNetwork
//
//  Created by Victorien Druon on 04/03/2024.
//

import Foundation

struct Movie: Identifiable, Codable, Equatable, Hashable, Posterable, Backdropable {
    let id: Int
    let title: String
    let tagline: String?
    let originalTitle: String?
    let originalLanguage: String?
    let overview: String?
    let runtime: Int?
    let genreIds: [Int]?
    let genres: [Genre]?
    let releaseDate: Date?
    let posterPath: URL?
    let backdropPath: URL?
    let budget: Double?
    let revenue: Double?
    let homepageURL: URL?
    let imdbID: String?
    let status: Status?
    let productionCompanies: [ProductionCompany]?
    let productionCountries: [ProductionCountry]?
    let spokenLanguages: [SpokenLanguage]?
    let popularity: Double?
    let voteAverage: Double?
    let voteCount: Int?
    let hasVideo: Bool?
    let isAdultOnly: Bool?
    let credits: ShowCredits?
    let recommendations: MoviePageableList?
    let videos: VideoCollection?

    init(
        id: Int,
        title: String,
        tagline: String? = nil,
        originalTitle: String? = nil,
        originalLanguage: String? = nil,
        overview: String? = nil,
        runtime: Int? = nil,
        genreIds: [Int]? = nil,
        genres: [Genre]? = nil,
        releaseDate: Date? = nil,
        posterPath: URL? = nil,
        backdropPath: URL? = nil,
        budget: Double? = nil,
        revenue: Double? = nil,
        homepageURL: URL? = nil,
        imdbID: String? = nil,
        status: Status? = nil,
        productionCompanies: [ProductionCompany]? = nil,
        productionCountries: [ProductionCountry]? = nil,
        spokenLanguages: [SpokenLanguage]? = nil,
        popularity: Double? = nil,
        voteAverage: Double? = nil,
        voteCount: Int? = nil,
        hasVideo: Bool? = nil,
        isAdultOnly: Bool? = nil,
        credits: ShowCredits? = nil,
        recommendations: MoviePageableList? = nil,
        videos: VideoCollection? = nil
    ) {
        self.id = id
        self.title = title
        self.tagline = tagline
        self.originalTitle = originalTitle
        self.originalLanguage = originalLanguage
        self.overview = overview
        self.runtime = runtime
        self.genreIds = genreIds
        self.genres = genres
        self.releaseDate = releaseDate
        self.posterPath = posterPath
        self.backdropPath = backdropPath
        self.budget = budget
        self.revenue = revenue
        self.homepageURL = homepageURL
        self.imdbID = imdbID
        self.status = status
        self.productionCompanies = productionCompanies
        self.productionCountries = productionCountries
        self.spokenLanguages = spokenLanguages
        self.popularity = popularity
        self.voteAverage = voteAverage
        self.voteCount = voteCount
        self.hasVideo = hasVideo
        self.isAdultOnly = isAdultOnly
        self.credits = credits
        self.recommendations = recommendations
        self.videos = videos
    }
}

extension Movie {
    func toShow() -> Show {
        return Show.movie(self)
    }
}

extension [Movie] {
    func toShows() -> [Show] {
        return self.map { $0.toShow() }
    }
}

extension Movie {
    private enum CodingKeys: String, CodingKey {
        case id
        case title
        case tagline
        case originalTitle
        case originalLanguage
        case overview
        case runtime
        case genreIds
        case genres
        case releaseDate
        case posterPath
        case backdropPath
        case budget
        case revenue
        case homepageURL = "homepage"
        case imdbID = "imdbId"
        case status
        case productionCompanies
        case productionCountries
        case spokenLanguages
        case popularity
        case voteAverage
        case voteCount
        case hasVideo = "video"
        case isAdultOnly = "adult"
        case credits
        case recommendations
        case videos
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let container2 = try decoder.container(keyedBy: CodingKeys.self)

        self.id = try container.decode(Int.self, forKey: .id)
        self.title = try container.decode(String.self, forKey: .title)
        self.tagline = try container.decodeIfPresent(String.self, forKey: .tagline)
        self.originalTitle = try container.decodeIfPresent(String.self, forKey: .originalTitle)
        self.originalLanguage = try container.decodeIfPresent(String.self, forKey: .originalLanguage)
        self.overview = try container.decodeIfPresent(String.self, forKey: .overview)
        self.runtime = try container.decodeIfPresent(Int.self, forKey: .runtime)
        self.genreIds = try container.decodeIfPresent([Int].self, forKey: .genreIds)
        self.genres = try container.decodeIfPresent([Genre].self, forKey: .genres)

        // Need to deal with empty strings - date decoding will fail with an empty string
        let releaseDateString = try container.decodeIfPresent(String.self, forKey: .releaseDate)
        self.releaseDate = try {
            guard let releaseDateString, !releaseDateString.isEmpty else {
                return nil
            }

            return try container2.decodeIfPresent(Date.self, forKey: .releaseDate)
        }()

        self.posterPath = try container.decodeIfPresent(URL.self, forKey: .posterPath)
        self.backdropPath = try container.decodeIfPresent(URL.self, forKey: .backdropPath)
        self.budget = try container.decodeIfPresent(Double.self, forKey: .budget)
        self.revenue = try container.decodeIfPresent(Double.self, forKey: .revenue)

        // Need to deal with empty strings - URL decoding will fail with an empty string
        let homepageURLString = try container.decodeIfPresent(String.self, forKey: .homepageURL)
        self.homepageURL = try {
            guard let homepageURLString, !homepageURLString.isEmpty else {
                return nil
            }

            return try container2.decodeIfPresent(URL.self, forKey: .homepageURL)
        }()

        self.imdbID = try container.decodeIfPresent(String.self, forKey: .imdbID)
        self.status = try container.decodeIfPresent(Status.self, forKey: .status)
        self.productionCompanies = try container.decodeIfPresent([ProductionCompany].self, forKey: .productionCompanies)
        self.productionCountries = try container.decodeIfPresent([ProductionCountry].self, forKey: .productionCountries)
        self.spokenLanguages = try container.decodeIfPresent([SpokenLanguage].self, forKey: .spokenLanguages)
        self.popularity = try container.decodeIfPresent(Double.self, forKey: .popularity)
        self.voteAverage = try container.decodeIfPresent(Double.self, forKey: .voteAverage)
        self.voteCount = try container.decodeIfPresent(Int.self, forKey: .voteCount)
        self.hasVideo = try container.decodeIfPresent(Bool.self, forKey: .hasVideo)
        self.isAdultOnly = try container.decodeIfPresent(Bool.self, forKey: .isAdultOnly)
        self.credits = try container.decodeIfPresent(ShowCredits.self, forKey: .credits)
        self.recommendations = try container.decodeIfPresent(MoviePageableList.self, forKey: .recommendations)
        self.videos = try container.decodeIfPresent(VideoCollection.self, forKey: .videos)
    }
}
