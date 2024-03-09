//
//  ProfileView.swift
//  MovieNetwork
//
//  Created by Victorien Druon on 20/02/2024.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var session: SessionManager
    @EnvironmentObject var navigation: NavigationManager

    var body: some View {
        if !session.isAuthenticated {
            AuthRequiredView(message: "You need to sign up to have a profile.")
        }

        else {
            List {
                Button("Dis-onboard") {
                    UserDefaults.standard.set(false, forKey: "isOnBoarded")
                }

                Button("Sign out") {
                    Task {
                        try? await SupabaseManager.shared.signOut()
                    }
                }
            }
        }
    }
}

#Preview {
    @StateObject var session = SessionManager()
    @StateObject var navigation = NavigationManager()

    return
        NavigationStack(path: $navigation.profileStack) {
            ProfileView()
                .navigationTitle("Profile")
                .navigationBarTitleDisplayMode(.inline)
                .navigationDestination(
                    for: Destination.self,
                    destination: navigation.routeTo
                )
                .toolbar { ProfileToolbar() }
        }
        .environmentObject(session)
        .environmentObject(navigation)
}
