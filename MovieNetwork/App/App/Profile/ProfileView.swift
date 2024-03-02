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
            NavigationStack {
                AuthRequiredView(message: "You need to sign up to have a profile.")
                    .navigationTitle("Profile")
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar {
                        Button("Done") {
                            navigation.showingProfile = false
                        }
                        .foregroundStyle(.accent9)
                    }
            }

        } else {
            NavigationStack(path: $navigation.profileStack) {
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
                .navigationTitle("Profile")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    Button("Done") {
                        navigation.showingProfile = false
                    }
                    .foregroundStyle(.accent9)
                }
            }
        }
    }
}

#Preview {
    ProfileView()
        .environmentObject(SessionManager())
        .environmentObject(NavigationManager())
}
