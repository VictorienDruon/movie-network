//
//  VideoType.swift
//  MovieNetwork
//
//  Created by Victorien Druon on 08/03/2024.
//

import Foundation

enum VideoType: String, Codable, Equatable, Hashable {
    case trailer = "Trailer"
    case teaser = "Teaser"
    case clip = "Clip"
    case openingCredits = "Opening Credits"
    case featurette = "Featurette"
    case behindTheScenes = "Behind the Scenes"
    case bloopers = "Bloopers"
    case unknown

    init(from decoder: Decoder) throws {
        self = try VideoType(rawValue: decoder.singleValueContainer().decode(RawValue.self)) ?? .unknown
    }
}
