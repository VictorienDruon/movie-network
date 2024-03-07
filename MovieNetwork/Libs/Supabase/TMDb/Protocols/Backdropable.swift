//
//  Backdropable.swift
//  MovieNetwork
//
//  Created by Victorien Druon on 07/03/2024.
//

import Foundation

protocol Backdropable {
    var backdropPath: URL? { get }
}

extension Backdropable {
    var backdropUrl: (BackdropImageSize) -> URL? {
        { size in imageUrl(path: self.backdropPath, size: .backdrop(size)) }
    }
}
