//
//  VideoMetadata.swift
//  MovieNetwork
//
//  Created by Victorien Druon on 08/03/2024.
//

import Foundation

struct VideoMetadata: Identifiable, Codable, Equatable, Hashable {
    let id: String
    let name: String
    let site: String
    let key: String
    let type: VideoType
    let size: VideoSize

    init(
        id: String,
        name: String,
        site: String,
        key: String,
        type: VideoType,
        size: VideoSize
    ) {
        self.id = id
        self.name = name
        self.site = site
        self.key = key
        self.type = type
        self.size = size
    }
}
