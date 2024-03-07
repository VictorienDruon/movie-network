//
//  ProductionCountry.swift
//  MovieNetwork
//
//  Created by Victorien Druon on 04/03/2024.
//

import Foundation

struct ProductionCountry: Identifiable, Codable, Equatable, Hashable {
    var id: String { countryCode }
    let countryCode: String
    let name: String

    init(countryCode: String, name: String) {
        self.countryCode = countryCode
        self.name = name
    }
}

extension ProductionCountry {
    private enum CodingKeys: String, CodingKey {
        case countryCode = "iso31661"
        case name
    }
}
