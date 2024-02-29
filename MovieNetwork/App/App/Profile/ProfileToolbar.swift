//
//  ProfileToolbar.swift
//  MovieNetwork
//
//  Created by Victorien Druon on 20/02/2024.
//

import SwiftUI

struct ProfileToolbar: View {
    @EnvironmentObject var navigation: Navigation

    var body: some View {
        Button("Profile", systemImage: "person.crop.circle") {
            navigation.showingProfile = true
        }
        .labelStyle(.iconOnly)
    }
}

#Preview {
    ProfileToolbar()
}
