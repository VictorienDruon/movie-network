//
//  SearchView.swift
//  MovieNetwork
//
//  Created by Victorien Druon on 13/03/2024.
//

import SwiftUI

struct SearchView: View {
    @StateObject var viewModel = SearchViewModel()
    @FocusState private var isSearchbarFocused: Bool

    var body: some View {
        ZStack(alignment: .bottom) {
            List {
                if let results = viewModel.results, !results.isEmpty {
                    ForEach(results) { media in
                        MediaRow(media: media)
                    }
                    .listRowBackground(Color.white.opacity(0))
                }
            }
            .listStyle(.inset)
            .contentMargins(.bottom, 96)
            .scrollContentBackground(.hidden)
            .scrollDismissesKeyboard(.immediately)

            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundStyle(.tertiary)
                TextField("Movies, series and more", text: $viewModel.query)
                    .foregroundStyle(.neutral11)
                    .keyboardType(.asciiCapable)
                    .autocorrectionDisabled()
                    .focused($isSearchbarFocused)
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            isSearchbarFocused = true
                        }
                    }
                    .onChange(of: viewModel.debouncedQuery, viewModel.search)
            }
            .font(.system(size: 22, weight: .medium, design: .rounded))
            .padding(.horizontal, 16)
            .frame(height: 55)
            .background(.regularMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 14))
            .shadowSize(.large)
            .padding()
        }
    }
}

#Preview {
    @StateObject var navigation = NavigationManager()

    return
        NavigationStack(path: $navigation.searchStack) {
            SearchView()
                .navigationTitle("Search")
                .navigationBarTitleDisplayMode(.inline)
                .navigationDestination(
                    for: Destination.self,
                    destination: navigation.routeTo
                )
        }
}
