//
//  AspectRatio.swift
//  MovieNetwork
//
//  Created by Victorien Druon on 05/03/2024.
//

import Foundation

enum AspectRatio {
    case poster
    case backdrop
    case logo

    var value: Double {
        switch self {
        case .poster: 5/7
        case .backdrop: 16/9
        case .logo: 1
        }
    }
}
