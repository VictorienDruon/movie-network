//
//  ProfileControls.swift
//  MovieNetwork
//
//  Created by Victorien Druon on 09/04/2024.
//

import SwiftUI

struct ProfileControls: View {
    @EnvironmentObject var viewModel: ProfileViewModel

    var body: some View {
        if viewModel.isCurrentUser {
            Button("Edit", systemImage: "pencil") {}
                .labelStyle(LabelLayout(.left, .medium))
                .buttonStyle(StyledButton(.primaryOutline, .medium))
        } else {
            ZStack {
                if viewModel.doesFollow {
                    Button("Unfollow", systemImage: "person.crop.circle.fill.badge.xmark") {
                        viewModel.unfollow()
                    }
                    .labelStyle(LabelLayout(.left, .medium))
                    .buttonStyle(StyledButton(.primaryOutline, .medium))
                } else {
                    Button("Follow", systemImage: "person.crop.circle.fill.badge.plus") {
                        viewModel.follow()
                    }
                    .labelStyle(LabelLayout(.left, .medium))
                    .buttonStyle(StyledButton(.primary, .medium))
                }
            }
            .animation(.bouncy, value: viewModel.doesFollow)
            .sensoryFeedback(.success, trigger: viewModel.triggerControlsHaptic)
        }
    }
}

#Preview {
    ProfileControls()
        .environmentObject(ProfileViewModel(for: sampleUser1, with: sampleUser2))
}
