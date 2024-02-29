//
//  FeedView.swift
//  MovieNetwork
//
//  Created by Victorien Druon on 18/02/2024.
//

import SwiftUI

struct FeedView: View {
    @EnvironmentObject var session: AuthSession
    @EnvironmentObject var navigation: Navigation

    var body: some View {
        if !session.isAuthenticated {
            NavigationStack {
                AuthRequiredView(message: "You need to sign up to access the Feed.")
                    .navigationTitle("Feed")
                    .toolbar {
                        ProfileToolbar()
                    }
            }

        } else {
            NavigationStack(path: $navigation.feedStack) {
                Text("Feed")
                    .navigationTitle("Feed")
                    .toolbar {
                        ProfileToolbar()
                    }
            }
        }
    }
}

#Preview {
    FeedView()
        .environmentObject(AuthSession())
        .environmentObject(Navigation())
}