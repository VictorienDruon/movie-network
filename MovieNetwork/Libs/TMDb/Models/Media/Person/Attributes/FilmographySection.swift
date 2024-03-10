//
//  FilmographySection.swift
//  MovieNetwork
//
//  Created by Victorien Druon on 10/03/2024.
//

import Foundation

typealias Filmography = [FilmographySection]

struct FilmographySection: Identifiable {
    var id: String { name }
    var name: String
    var shows: [Show]?
}

extension [FilmographySection] {
    func sortByShowCount() -> [FilmographySection] {
        return self.sorted { section1, section2 -> Bool in
            section1.shows?.count ?? 0 > section2.shows?.count ?? 0
        }
    }
}
