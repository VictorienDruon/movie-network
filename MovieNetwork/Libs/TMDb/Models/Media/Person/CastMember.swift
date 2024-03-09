//
//  CastMember.swift
//  MovieNetwork
//
//  Created by Victorien Druon on 04/03/2024.
//

import Foundation

struct CastMember: Identifiable, Codable, Equatable, Hashable, Profilable {
    let id: Int
    let castID: Int?
    let creditID: String
    let name: String
    let character: String
    let gender: Gender?
    let profilePath: URL?
    let order: Int

    init(
        id: Int,
        castID: Int? = nil,
        creditID: String,
        name: String,
        character: String,
        gender: Gender? = nil,
        profilePath: URL? = nil,
        order: Int
    ) {
        self.id = id
        self.castID = castID
        self.creditID = creditID
        self.name = name
        self.character = character
        self.gender = gender
        self.profilePath = profilePath
        self.order = order
    }
}

extension CastMember {
    func toPerson() -> Person {
        return Person(
            id: self.id,
            name: self.name,
            gender: self.gender ?? .unknown,
            profilePath: self.profilePath
        )
    }
}

extension CastMember {
    private enum CodingKeys: String, CodingKey {
        case id
        case castID = "castId"
        case creditID = "creditId"
        case name
        case character
        case gender
        case profilePath
        case order
    }
}
