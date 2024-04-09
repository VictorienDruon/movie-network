//
//  Profiles.swift
//  MovieNetwork
//
//  Created by Victorien Druon on 10/04/2024.
//

import Foundation

extension RemoteDbManager {
    func getUser(_ id: UUID) async throws -> User? {
        let users: [User] = try await database
            .from("profiles")
            .select()
            .eq("id", value: id)
            .limit(1)
            .execute()
            .value
        return users.first
    }
}
