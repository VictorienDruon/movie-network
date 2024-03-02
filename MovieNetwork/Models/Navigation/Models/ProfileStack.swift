//
//  ProfileStack.swift
//  MovieNetwork
//
//  Created by Victorien Druon on 20/02/2024.
//

import Foundation

typealias ProfileStack = [ProfileDestination]

enum ProfileDestination {
    case movie
    case tvSeries
    case profile
    case settings
}
