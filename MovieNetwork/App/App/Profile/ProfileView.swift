//
//  ProfileView.swift
//  MovieNetwork
//
//  Created by Victorien Druon on 20/02/2024.
//

import SwiftUI

struct ProfileView: View {
    @StateObject private var viewModel: ProfileViewModel

    init(for user: User, with currentUser: User) {
        _viewModel = StateObject(wrappedValue: ProfileViewModel(for: user, with: currentUser))
    }

    var body: some View {
        ScrollView {
            LazyVStack(spacing: 16) {
                Avatar(id: viewModel.user.id, url: viewModel.user.avatarUrl, size: .medium)

                Title2(viewModel.user.name ?? "Unknown")

                HStack {
                    Headline("\(viewModel.followingCount) Following")
                    Headline("•")
                    Headline("\(viewModel.followersCount) Followers")
                }

                ProfileControls()
            }
        }
        .contentMargins(.vertical, 16)
        .scrollIndicators(.hidden)
        .navigationTitle(viewModel.user.name ?? "Unknown")
        .navigationBarTitleDisplayMode(.inline)
        .environmentObject(viewModel)
    }
}

#Preview {
    @StateObject var navigation = NavigationManager()
    let user = User(id: UUID(), name: "John Doe", avatarUrl: nil)
    let currentUser = User(id: UUID(), name: "Lorem Ipsum", avatarUrl: nil)

    return
        NavigationStack(path: $navigation.profileStack) {
            ProfileView(for: user, with: currentUser)
                .navigationDestination(
                    for: Destination.self,
                    destination: navigation.routeTo
                )
        }
}
