//
//  VideoSize.swift
//  MovieNetwork
//
//  Created by Victorien Druon on 08/03/2024.
//

import Foundation

enum VideoSize: Int, Codable, Equatable, Hashable {
    case s360 = 360
    case s480 = 480
    case s720 = 720
    case s1080 = 1080
    case unknown

    init(from decoder: Decoder) throws {
        self = try VideoSize(rawValue: decoder.singleValueContainer().decode(RawValue.self)) ?? .unknown
    }
}
