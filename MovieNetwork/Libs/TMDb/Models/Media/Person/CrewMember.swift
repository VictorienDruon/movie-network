//
//  CrewMember.swift
//  MovieNetwork
//
//  Created by Victorien Druon on 04/03/2024.
//

import Foundation

struct CrewMember: Identifiable, Codable, Equatable, Hashable, Profilable {
    let id: Int
    let creditID: String
    let name: String
    let job: String
    let department: String
    let gender: Gender?
    let profilePath: URL?

    init(
        id: Int,
        creditID: String,
        name: String,
        job: String,
        department: String,
        gender: Gender? = nil,
        profilePath: URL? = nil
    ) {
        self.id = id
        self.creditID = creditID
        self.name = name
        self.job = job
        self.department = department
        self.gender = gender
        self.profilePath = profilePath
    }
}

extension CrewMember {
    private enum CodingKeys: String, CodingKey {
        case id
        case creditID = "creditId"
        case name
        case job
        case department
        case gender
        case profilePath
    }
}
