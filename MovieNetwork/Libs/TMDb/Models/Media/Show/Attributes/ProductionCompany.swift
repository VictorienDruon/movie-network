//
//  ProductionCompany.swift
//  MovieNetwork
//
//  Created by Victorien Druon on 04/03/2024.
//

import Foundation

struct ProductionCompany: Identifiable, Codable, Equatable, Hashable {
    let id: Int
    let name: String
    let originCountry: String
    let logoPath: URL?

    init(
        id: Int, name: String,
        originCountry: String,
        logoPath: URL? = nil
    ) {
        self.id = id
        self.name = name
        self.originCountry = originCountry
        self.logoPath = logoPath
    }
}
