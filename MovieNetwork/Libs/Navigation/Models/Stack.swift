//
//  Stack.swift
//  MovieNetwork
//
//  Created by Victorien Druon on 18/02/2024.
//

import Foundation

typealias Stack = [Destination]

enum Destination: Hashable {
    case show(Show)
    case person(Person)
    case profile(User, User)
}
