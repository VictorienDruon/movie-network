//
//  SpokenLanguage.swift
//  MovieNetwork
//
//  Created by Victorien Druon on 04/03/2024.
//

import Foundation

struct SpokenLanguage: Identifiable, Codable, Equatable, Hashable {
    var id: String { languageCode }
    let languageCode: String
    let name: String

    init(languageCode: String, name: String) {
        self.languageCode = languageCode
        self.name = name
    }
}

extension SpokenLanguage {
    private enum CodingKeys: String, CodingKey {
        case languageCode = "iso6391"
        case name
    }
}
