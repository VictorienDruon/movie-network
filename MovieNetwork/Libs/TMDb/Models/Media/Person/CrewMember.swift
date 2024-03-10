//
//  CrewMember.swift
//  MovieNetwork
//
//  Created by Victorien Druon on 04/03/2024.
//

import Foundation

struct CrewMember: Identifiable, Codable, Equatable, Hashable, Profilable {
    let id: Int
    let creditID: String?
    let name: String
    let job: String?
    let jobs: [Job]?
    let department: String
    let gender: Gender?
    let profilePath: URL?

    init(
        id: Int,
        creditID: String? = nil,
        name: String,
        job: String? = nil,
        jobs: [Job]? = nil,
        department: String,
        gender: Gender? = nil,
        profilePath: URL? = nil
    ) {
        self.id = id
        self.creditID = creditID
        self.name = name
        self.job = job
        self.jobs = jobs
        self.department = department
        self.gender = gender
        self.profilePath = profilePath
    }
}

extension CrewMember {
    func toPerson() -> Person {
        return Person(
            id: self.id,
            name: self.name,
            gender: self.gender ?? .unknown,
            profilePath: self.profilePath
        )
    }

    func isJobRelevant() -> Bool {
        let relevantJobs = ["Director", "Screenplay", "Writer", "Original Music Composer"]
        if let job = self.job ?? self.jobs?.first?.job {
            return relevantJobs.contains(job)
        } else {
            return false
        }
    }
}

extension [CrewMember] {
    func filterRelevantJobs() -> [CrewMember] {
        return self.filter { $0.isJobRelevant() }
    }
}

extension CrewMember {
    private enum CodingKeys: String, CodingKey {
        case id
        case creditID = "creditId"
        case name
        case job
        case jobs
        case department
        case gender
        case profilePath
    }
}
