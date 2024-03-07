//
//  Profilable.swift
//  MovieNetwork
//
//  Created by Victorien Druon on 07/03/2024.
//

import Foundation

protocol Profilable {
    var profilePath: URL? { get }
}

extension Profilable {
    var profileUrl: (ProfileImageSize) -> URL? {
        { size in imageUrl(path: self.profilePath, size: .profile(size)) }
    }
}
