//
//  MediaSearchView.swift
//  MovieNetwork
//
//  Created by Victorien Druon on 13/03/2024.
//

import SwiftUI

struct MediaSearchView: View {
    @StateObject var viewModel = MediaSearchViewModel()

    var body: some View {
        ZStack(alignment: .bottom) {
            List {
                ForEach(viewModel.results) { media in
                    MediaRow(media: media)
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

    return
        NavigationStack(path: $navigation.mediaSearchStack) {
            MediaSearchView()
                .navigationTitle("Search")
                .navigationBarTitleDisplayMode(.inline)
                .navigationDestination(
                    for: Destination.self,
                    destination: navigation.routeTo
                )
        }
}
