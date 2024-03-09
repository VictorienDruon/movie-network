//
//  ProfileToolbar.swift
//  MovieNetwork
//
//  Created by Victorien Druon on 09/03/2024.
//

import SwiftUI

struct ProfileToolbar: ToolbarContent {
    @EnvironmentObject var navigation: NavigationManager

    var body: some ToolbarContent {
        ToolbarItem(placement: .confirmationAction) {
            Button("OK") {
                navigation.showingProfile = false
            }
        }
    }
}

#Preview {
    @StateObject var navigation = NavigationManager()

    return NavigationStack {
        ScrollView {}
            .navigationTitle("Test")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar { ProfileToolbar() }
            .environmentObject(navigation)
    }
}
