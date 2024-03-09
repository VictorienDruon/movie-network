//
//  VideoCollection.swift
//  MovieNetwork
//
//  Created by Victorien Druon on 08/03/2024.
//

import Foundation

struct VideoCollection: Codable, Equatable, Hashable {
    let results: [VideoMetadata]

    var trailerKey: String? {
        let trailers = results.filter { video in
            video.type == .trailer
        }
        return trailers.first?.key
    }

    init(results: [VideoMetadata]) {
        self.results = results
    }
}
