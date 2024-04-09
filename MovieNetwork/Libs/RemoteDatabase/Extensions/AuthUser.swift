//
//  AuthUser.swift
//  MovieNetwork
//
//  Created by Victorien Druon on 08/04/2024.
//

import struct Auth.User
import Foundation

extension Auth.User {
    func format() -> User {
        let name = userMetadata["full_name"]?.stringValue

        var avatarUrl: URL?
        if let avatarString = userMetadata["avatar_url"]?.stringValue {
            avatarUrl = URL(string: avatarString)
        }

        return User(id: id, name: name, avatarUrl: avatarUrl)
    }
}

