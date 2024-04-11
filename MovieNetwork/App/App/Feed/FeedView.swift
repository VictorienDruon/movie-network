//
//  FeedView.swift
//  MovieNetwork
//
//  Created by Victorien Druon on 18/02/2024.
//

import SwiftUI

struct FeedView: View {
    @EnvironmentObject var navigation: NavigationManager

    var currentUser: User

    init(for currentUser: User) {
        self.currentUser = currentUser
    }

    var body: some View {
        ZStack(alignment: .bottom) {
            ScrollView {}
                .contentMargins(.top, 16)
                .contentMargins(.bottom, 96)
                .scrollIndicators(.hidden)

            Button("Search", systemImage: "magnifyingglass") {
                navigation.showingUserSearch = true
            }
            .labelStyle(LabelLayout(.left, .medium))
            .buttonStyle(StyledButton(.secondaryOutline, .medium))
            .padding()
        }
    }
}

#Preview {
    @StateObject var navigation = NavigationManager()
    let currentUser = User(id: UUID(), name: "Lorem Ipsum", avatarUrl: nil)

    return
        TabView {
            NavigationStack(path: $navigation.feedStack) {
                FeedView(for: currentUser)
                    .navigationTitle("Feed")
                    .navigationBarTitleDisplayMode(.large)
                    .navigationDestination(
                        for: Destination.self,
                        destination: navigation.routeTo
                    )
                    .toolbar { ProfileTrigger() }
            }
            .tag(Tab.feed)
            .tabItem { Image(systemName: "bolt.fill") }
        }
        .environmentObject(navigation)
}
