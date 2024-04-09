//
//  Follows.swift
//  MovieNetwork
//
//  Created by Victorien Druon on 09/04/2024.
//

import Foundation

extension RemoteDbManager {
    func getFollow(_ followedId: UUID, by followerId: UUID) async throws -> Follow? {
        let follow: [Follow] = try await database
            .from("follows")
            .select()
            .eq("follower_id", value: followerId)
            .eq("followed_id", value: followedId)
            .limit(1)
            .execute()
            .value
        return follow.first
    }

    func getFollowingCount(_ userId: UUID) async throws -> Int {
        return try await database
            .from("follows")
            .select("*", head: true, count: .exact)
            .eq("follower_id", value: userId)
            .execute()
            .count ?? 0
    }

    func getFollowersCount(_ userId: UUID) async throws -> Int {
        return try await database
            .from("follows")
            .select("*", head: true, count: .exact)
            .eq("followed_id", value: userId)
            .execute()
            .count ?? 0
    }

    @discardableResult
    func follow(_ followedId: UUID, by followerId: UUID) async throws -> Follow {
        let follow = Follow(followerId: followerId, followedId: followedId, createdAt: .now)
        return try await database
            .from("follows")
            .insert(follow, returning: .representation)
            .single()
            .execute()
            .value
    }

    func unfollow(_ followedId: UUID, by followerId: UUID) async throws {
        try await database
            .from("follows")
            .delete()
            .eq("follower_id", value: followerId)
            .eq("followed_id", value: followedId)
            .execute()
    }
}
