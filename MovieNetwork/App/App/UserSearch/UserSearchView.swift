//
//  UserSearchView.swift
//  MovieNetwork
//
//  Created by Victorien Druon on 11/04/2024.
//

import SwiftUI

struct UserSearchView: View {
    @StateObject var viewModel = UserSearchViewModel()

    var currentUser: User

    init(for currentUser: User) {
        self.currentUser = currentUser
    }

    var body: some View {
        ZStack(alignment: .bottom) {
            List {
                ForEach(viewModel.results) { user in
                    UserRow(user: user, currentUser: currentUser)
                }
                .listRowBackground(Color.white.opacity(0))
            }
            .listStyle(.inset)
            .contentMargins(.bottom, 96)
            .scrollContentBackground(.hidden)
            .scrollDismissesKeyboard(.immediately)

            SearchBar(placeholder: "Movies, series and more", onChange: viewModel.search)
        }
    }
}

#Preview {
    @StateObject var navigation = NavigationManager()
    let currentUser = User(id: UUID(), name: "Lorem Ipsum", avatarUrl: nil)

    return
        NavigationStack(path: $navigation.userSearchStack) {
            UserSearchView(for: currentUser)
                .navigationTitle("Search")
                .navigationBarTitleDisplayMode(.inline)
                .navigationDestination(
                    for: Destination.self,
                    destination: navigation.routeTo
                )
        }
}
