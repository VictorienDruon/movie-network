//
//  Posterable.swift
//  MovieNetwork
//
//  Created by Victorien Druon on 07/03/2024.
//

import Foundation

protocol Posterable {
    var posterPath: URL? { get }
}

extension Posterable {
    var posterUrl: (PosterImageSize) -> URL? {{ size in
        imageUrl(path: self.posterPath, size: .poster(size))
    }}
}
