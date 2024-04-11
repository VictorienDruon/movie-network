//
//  User.swift
//  MovieNetwork
//
//  Created by Victorien Druon on 08/04/2024.
//

import Foundation

struct User: Hashable, Equatable, Identifiable, Codable {
    var id: UUID
    var name: String
    var avatarUrl: URL?

    init(id: UUID, name: String?, avatarUrl: URL?) {
        self.id = id
        self.name = name ?? "Unknown"
        self.avatarUrl = avatarUrl
    }

    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case avatarUrl = "avatar_url"
    }
}

extension User {
    var link: URL {
        URL(string: "\(appScheme)user/\(id)")!
    }
}

extension User {
    static func ==(lhs: User, rhs: User) -> Bool {
        return lhs.id == rhs.id
    }
}
