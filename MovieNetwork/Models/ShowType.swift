//
//  ShowType.swift
//  MovieNetwork
//
//  Created by Victorien Druon on 29/02/2024.
//

import Foundation

enum ShowType: CaseIterable, Identifiable {
    case movie
    case tvSeries

    var name: String {
        switch self {
        case .movie: "Movie"
        case .tvSeries: "TV Show"
        }
    }

    var id: Self {
        return self
    }
}
