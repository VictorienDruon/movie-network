//
//  ProfileViewModel.swift
//  MovieNetwork
//
//  Created by Victorien Druon on 08/04/2024.
//

import Foundation

@MainActor
class ProfileViewModel: ObservableObject {
    @Published var user: User
    @Published var currentUser: User
    @Published var followingCount = 0
    @Published var followersCount = 0
    @Published var doesFollow = false
    var isCurrentUser: Bool {
        user == currentUser
    }

    @Published var isDisabled = true

    @Published var triggerControlsHaptic = 0

    init(for user: User, with currentUser: User) {
        self.user = user
        self.currentUser = currentUser
        getAll()
    }

    func getAll() {
        Task {
            await withTaskGroup(of: Void.self) { group in
                group.addTask { await self.getFollowingCount() }
                group.addTask { await self.getFollowersCount() }
                group.addTask { await self.doesFollowUser() }
            }
            isDisabled = false
        }
    }

    func getFollowingCount() {
        Task {
            followingCount = try await RemoteDbManager.shared.getFollowingCount(user.id)
        }
    }

    func getFollowersCount() {
        Task {
            followersCount = try await RemoteDbManager.shared.getFollowersCount(user.id)
        }
    }

    func doesFollowUser() {
        if !isCurrentUser {
            Task {
                doesFollow = try await RemoteDbManager.shared.getFollow(user.id, by: currentUser.id) != nil
            }
        }
    }

    func follow() {
        if !isDisabled && !isCurrentUser {
            Task {
                isDisabled = true
                try await RemoteDbManager.shared.follow(user.id, by: currentUser.id)
                doesFollow = true
                followersCount += 1
                triggerControlsHaptic += 1
                isDisabled = false
            }
        }
    }

    func unfollow() {
        if !isDisabled && !isCurrentUser {
            Task {
                isDisabled = true
                try await RemoteDbManager.shared.unfollow(user.id, by: currentUser.id)
                doesFollow = false
                followersCount -= 1
                triggerControlsHaptic += 1
                isDisabled = false
            }
        }
    }
}
