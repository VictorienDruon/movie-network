//
//  Status.swift
//  MovieNetwork
//
//  Created by Victorien Druon on 04/03/2024.
//

import Foundation

enum Status: String, Codable, Equatable, Hashable {
    case rumoured = "Rumored"
    case planned = "Planned"
    case inProduction = "In Production"
    case postProduction = "Post Production"
    case released = "Released"
    case cancelled = "Canceled"
}
