//
//  PersonView.swift
//  MovieNetwork
//
//  Created by Victorien Druon on 07/03/2024.
//

import SwiftUI

struct PersonView: View {
    @StateObject private var viewModel: PersonViewModel

    init(for person: Person) {
        _viewModel = StateObject(wrappedValue: PersonViewModel(for: person))
    }

    var body: some View {
        ScrollView {
            LazyVStack(spacing: 32) {
                if let biography = viewModel.person.biography, !biography.isEmpty {
                    TextBlock(title: "Biography", content: biography)
                }

                if let movies = viewModel.movies, !movies.isEmpty {
                    Section("Movies") {
                        ShowPosters(shows: movies, variant: .bottomTitle, size: .small)
                    }
                }

                if let tvSeries = viewModel.tvSeries, !tvSeries.isEmpty {
                    Section("TV Shows") {
                        ShowPosters(shows: tvSeries, variant: .bottomTitle, size: .small)
                    }
                }
            }
            .padding(.vertical)
        }
        .scrollIndicators(.hidden)
        .navigationTitle(viewModel.person.name)
        .navigationBarTitleDisplayMode(.large)
        .toolbar { PersonToolbar() }
        .environmentObject(viewModel)
    }
}

#Preview {
    NavigationStack {
        PersonView(for: samplePerson)
    }
}
