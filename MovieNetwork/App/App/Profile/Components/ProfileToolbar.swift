//
//  ProfileToolbar.swift
//  MovieNetwork
//
//  Created by Victorien Druon on 11/04/2024.
//

import SwiftUI

struct ProfileToolbar: ToolbarContent {
    @EnvironmentObject var viewModel: ProfileViewModel

    var body: some ToolbarContent {
        ToolbarItem {
            Menu("More", systemImage: "ellipsis.circle") {
                Section {
                    ShareLink(
                        item: viewModel.user.link,
                        preview: SharePreview(
                            viewModel.user.name,
                            image: Image(uiImage: UIImage(named: "AppIcon") ?? UIImage())
                        )
                    )
                }

                if viewModel.isCurrentUser {
                    Section {
                        Button("Dis-onboard", systemImage: "list.bullet.clipboard") {
                            UserDefaults.standard.set(false, forKey: "isOnBoarded")
                        }
                        
                        Button("Sign out", systemImage: "rectangle.portrait.and.arrow.right") {
                            Task {
                                try await RemoteDbManager.shared.signOut()
                            }
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        ScrollView {}
            .navigationTitle("Test")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar { ProfileToolbar() }
            .environmentObject(ProfileViewModel(for: sampleUser1, with: sampleUser2))
    }
}
