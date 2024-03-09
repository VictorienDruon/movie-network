//
//  Person.swift
//  MovieNetwork
//
//  Created by Victorien Druon on 04/03/2024.
//

import Foundation

struct Person: Identifiable, Codable, Equatable, Hashable, Profilable {
    let id: Int
    let name: String
    let alsoKnownAs: [String]?
    let knownForDepartment: String?
    let biography: String?
    let birthday: Date?
    let deathday: Date?
    let gender: Gender
    let placeOfBirth: String?
    let profilePath: URL?
    let popularity: Double?
    let imdbID: String?
    let homepageURL: URL?
    let credits: PersonCredits?

    init(
        id: Int,
        name: String,
        alsoKnownAs: [String]? = nil,
        knownForDepartment: String? = nil,
        biography: String? = nil,
        birthday: Date? = nil,
        deathday: Date? = nil,
        gender: Gender,
        placeOfBirth: String? = nil,
        profilePath: URL? = nil,
        popularity: Double? = nil,
        imdbID: String? = nil,
        homepageURL: URL? = nil,
        credits: PersonCredits? = nil
    ) {
        self.id = id
        self.name = name
        self.alsoKnownAs = alsoKnownAs
        self.knownForDepartment = knownForDepartment
        self.biography = biography
        self.birthday = birthday
        self.deathday = deathday
        self.gender = gender
        self.placeOfBirth = placeOfBirth
        self.profilePath = profilePath
        self.popularity = popularity
        self.imdbID = imdbID
        self.homepageURL = homepageURL
        self.credits = credits
    }
}

extension Person {
    var link: URL {
        URL(string: "\(appScheme)person/\(self.id)")!
    }
}

extension Person {
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case alsoKnownAs
        case knownForDepartment
        case biography
        case birthday
        case deathday
        case gender
        case placeOfBirth
        case profilePath
        case popularity
        case imdbID = "imdbId"
        case homepageURL = "homepage"
        case credits = "combinedCredits"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let container2 = try decoder.container(keyedBy: CodingKeys.self)

        self.id = try container.decode(Int.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.alsoKnownAs = try container.decodeIfPresent([String].self, forKey: .alsoKnownAs)
        self.knownForDepartment = try container.decodeIfPresent(String.self, forKey: .knownForDepartment)
        self.biography = try container.decodeIfPresent(String.self, forKey: .biography)
        self.birthday = try container.decodeIfPresent(Date.self, forKey: .birthday)
        self.deathday = try container.decodeIfPresent(Date.self, forKey: .deathday)
        self.gender = (try? container.decodeIfPresent(Gender.self, forKey: .gender)) ?? .unknown
        self.placeOfBirth = try container.decodeIfPresent(String.self, forKey: .placeOfBirth)
        self.profilePath = try container.decodeIfPresent(URL.self, forKey: .profilePath)
        self.popularity = try container.decodeIfPresent(Double.self, forKey: .popularity)
        self.imdbID = try container.decodeIfPresent(String.self, forKey: .imdbID)

        // Need to deal with empty strings - URL decoding will fail with an empty string
        let homepageURLString = try container.decodeIfPresent(String.self, forKey: .homepageURL)
        self.homepageURL = try {
            guard let homepageURLString, !homepageURLString.isEmpty else {
                return nil
            }

            return try container2.decodeIfPresent(URL.self, forKey: .homepageURL)
        }()
        self.credits = try container.decodeIfPresent(PersonCredits.self, forKey: .credits)
    }
}
