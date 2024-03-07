//
//  Gender.swift
//  MovieNetwork
//
//  Created by Victorien Druon on 04/03/2024.
//

import Foundation

enum Gender: Int, Codable, Equatable, Hashable {
    case unknown = 0
    case female = 1
    case male = 2
    case other = 3

    init(from decoder: Decoder) throws {
        self = try Gender(rawValue: decoder.singleValueContainer().decode(RawValue.self)) ?? .unknown
    }
}
