//
//  ProfileView.swift
//  MovieNetwork
//
//  Created by Victorien Druon on 20/02/2024.
//

import SwiftUI

struct ProfileView: View {
    @StateObject private var viewModel: ProfileViewModel

    init(of user: User, for currentUser: User) {
        _viewModel = StateObject(wrappedValue: ProfileViewModel(for: user, with: currentUser))
    }

    var body: some View {
        ScrollView {
            LazyVStack(spacing: 16) {
                Avatar(id: viewModel.user.id, url: viewModel.user.avatarUrl, size: .medium)

                Title2(viewModel.user.name)

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
        .navigationTitle(viewModel.user.name)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar { ProfileToolbar() }
        .environmentObject(viewModel)
    }
}

#Preview {
    @StateObject var navigation = NavigationManager()

    return
        NavigationStack(path: $navigation.profileStack) {
            ProfileView(of: sampleUser1, for: sampleUser2)
                .navigationDestination(
                    for: Destination.self,
                    destination: navigation.routeTo
                )
        }
}
