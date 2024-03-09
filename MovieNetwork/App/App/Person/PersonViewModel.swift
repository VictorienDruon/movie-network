//
//  PersonViewModel.swift
//  MovieNetwork
//
//  Created by Victorien Druon on 07/03/2024.
//

import Foundation

@MainActor
final class PersonViewModel: ObservableObject {
    @Published var person: Person

    var movies: [Show]? {
        person.credits?.cast.filterMovies().sortByMostRecentRelease()
    }

    var tvSeries: [Show]? {
        person.credits?.cast.filterTvSeries().uniqued().sortByMostRecentRelease()
    }

    init(for person: Person) {
        self.person = person
        getPerson()
    }

    func getPerson() {
        Task {
            person = try await TMDbManager.shared.person(for: person.id)
        }
    }
}
