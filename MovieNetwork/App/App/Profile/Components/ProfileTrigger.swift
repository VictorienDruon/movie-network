//
//  ProfileTrigger.swift
//  MovieNetwork
//
//  Created by Victorien Druon on 20/02/2024.
//

import SwiftUI

struct ProfileTrigger: ToolbarContent {
    @EnvironmentObject var navigation: NavigationManager

    var body: some ToolbarContent {
        ToolbarItem {
            Button("Profile", systemImage: "person.crop.circle") {
                navigation.showingProfile = true
            }
            .labelStyle(.iconOnly)
        }
    }
}

#Preview {
    NavigationStack {
        ScrollView {}
            .navigationTitle("Test")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar { ProfileTrigger() }
    }
}
