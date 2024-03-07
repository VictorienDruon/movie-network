//
//  Network.swift
//  MovieNetwork
//
//  Created by Victorien Druon on 04/03/2024.
//

import Foundation

struct Network: Identifiable, Codable, Equatable, Hashable {
    let id: Int
    let name: String
    let logoPath: URL?
    let originCountry: String?

    init(
        id: Int,
        name: String,
        logoPath: URL? = nil,
        originCountry: String? = nil
    ) {
        self.id = id
        self.name = name
        self.logoPath = logoPath
        self.originCountry = originCountry
    }
}
