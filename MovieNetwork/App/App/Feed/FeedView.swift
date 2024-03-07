//
//  FeedView.swift
//  MovieNetwork
//
//  Created by Victorien Druon on 18/02/2024.
//

import SwiftUI

struct FeedView: View {
    @EnvironmentObject var session: SessionManager
    @EnvironmentObject var navigation: NavigationManager

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
                Title3("Feed")
                    .navigationTitle("Feed")
                    .navigationDestination(for: Destination.self, destination: navigation.routeTo)
                    .toolbar {
                        ProfileToolbar()
                    }
            }
        }
    }
}

#Preview {
    FeedView()
        .environmentObject(SessionManager())
        .environmentObject(NavigationManager())
}
