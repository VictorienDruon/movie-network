//
//  UserRow.swift
//  MovieNetwork
//
//  Created by Victorien Druon on 11/04/2024.
//

import SwiftUI

struct UserRow: View {
    var user: User
    var currentUser: User

    var body: some View {
        NavigationLink(value: Destination.profile(user, currentUser)) {
            HStack(spacing: 16) {
                Avatar(id: user.id, url: user.avatarUrl, size: .small)

                Headline(user.name)
                    .lineLimit(2)
            }
        }
    }
}

#Preview {
    UserRow(user: sampleUser1, currentUser: sampleUser2)
}
