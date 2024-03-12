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
                ForEach(viewModel.filmography) { section in
                    if let shows = section.shows, !shows.isEmpty {
                        Section(section.name) {
                            ShowPosters(shows: shows, variant: .bottomTitle, size: .small)
                        }
                    }
                }

                if let biography = viewModel.person.biography, !biography.isEmpty {
                    TextBlock(title: "Biography", content: biography)
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
