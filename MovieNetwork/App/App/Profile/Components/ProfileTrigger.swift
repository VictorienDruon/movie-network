//
//  ProfileTrigger.swift
//  MovieNetwork
//
//  Created by Victorien Druon on 20/02/2024.
//

import SwiftUI

struct ProfileTrigger: ToolbarContent {
    @EnvironmentObject var session: SessionManager
    @EnvironmentObject var navigation: NavigationManager

    var body: some ToolbarContent {
        ToolbarItem {
            ZStack {
                if let user = session.user {
                    Avatar(id: user.id, url: user.avatarUrl, size: .extraSmall)
                } else {
                    Image(systemName: "person.crop.circle")
                        .foregroundStyle(.accent9)
                }
            }
            .onTapGesture {
                navigation.showingProfile = true
            }
        }
    }
}

#Preview {
    NavigationStack {
        ScrollView {}
            .navigationTitle("Test")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar { ProfileTrigger() }
            .environmentObject(SessionManager())
            .environmentObject(NavigationManager())
    }
}
