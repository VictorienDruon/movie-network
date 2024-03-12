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
        person.credits?.cast.filterMovies().uniqued().sortByMostRecentRelease()
    }

    var tvSeries: [Show]? {
        person.credits?.cast.filterTvSeries().uniqued().sortByMostRecentRelease()
    }

    var directedShows: [Show]? {
        person.credits?.crew.filterByJobs(["Director"]).uniqued().sortByMostRecentRelease()
    }

    var writtenShows: [Show]? {
        person.credits?.crew.filterByJobs(["Screenplay", "Writer"]).uniqued().sortByMostRecentRelease()
    }

    var composedShows: [Show]? {
        person.credits?.crew.filterByJobs(["Original Music Composer"]).uniqued().sortByMostRecentRelease()
    }

    var filmography: Filmography {
        [
            FilmographySection(name: "Movies", shows: movies),
            FilmographySection(name: "TV Shows", shows: tvSeries),
            FilmographySection(name: "Director", shows: directedShows),
            FilmographySection(name: "Writer", shows: writtenShows),
            FilmographySection(name: "Composer", shows: composedShows)
        ]
        .sortByShowCount()
    }

    init(for person: Person) {
        self.person = person
        getPerson()
    }

    func getPerson() {
        Task {
            person = try await TMDbManager.shared.person(
                for: person.id,
                appendToResponse: [.combinedCredits]
            )
        }
    }
}
