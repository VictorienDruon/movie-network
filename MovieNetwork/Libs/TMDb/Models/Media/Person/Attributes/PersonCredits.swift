//
//  PersonCredits.swift
//  MovieNetwork
//
//  Created by Victorien Druon on 09/03/2024.
//

import Foundation

struct PersonCredits: Codable, Equatable, Hashable {
    let cast: [Show]
    let crew: [Show]

    init(cast: [Show], crew: [Show]) {
        self.cast = cast
        self.crew = crew
    }
}
