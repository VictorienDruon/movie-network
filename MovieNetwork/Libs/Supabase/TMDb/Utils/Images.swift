//
//  Images.swift
//  MovieNetwork
//
//  Created by Victorien Druon on 29/02/2024.
//

import Foundation

private let BASE_URL = URL(string: "https://image.tmdb.org/t/p")!

func imageUrl(path: URL?, size: ImageSize) -> URL? {
    guard let path else {
        return nil
    }

    return BASE_URL
        .appendingPathComponent(size.rawValue)
        .appendingPathComponent(path.absoluteString)
}

enum ImageSize {
    case backdrop(BackdropImageSize)
    case poster(PosterImageSize)
    case profile(ProfileImageSize)
    case logo(LogoImageSize)

    var rawValue: String {
        switch self {
        case let .backdrop(size): return size.rawValue
        case let .poster(size): return size.rawValue
        case let .profile(size): return size.rawValue
        case let .logo(size): return size.rawValue
        }
    }
}

enum BackdropImageSize: String {
    case w300, w780, w1280
    case original
}

enum PosterImageSize: String {
    case w92, w154, w185, w342, w500, w780
    case original
}

enum ProfileImageSize: String {
    case w45, w185
    case h632
    case original
}

enum LogoImageSize: String {
    case w45, w92, w154, w185, w300, w500
    case original
}
