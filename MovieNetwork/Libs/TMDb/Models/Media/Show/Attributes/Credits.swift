//
//  Credits.swift
//  MovieNetwork
//
//  Created by Victorien Druon on 08/03/2024.
//

import Foundation

struct Credits: Codable, Equatable, Hashable {
    let cast: [CastMember]
    let crew: [CrewMember]

    init(cast: [CastMember], crew: [CrewMember]) {
        self.cast = cast
        self.crew = crew
    }
}
