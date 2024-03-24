//
//  WatchlistItem.swift
//  MovieNetwork
//
//  Created by Victorien Druon on 24/03/2024.
//

import Foundation

protocol WatchlistItem {
    associatedtype Show: Showable

    var addedAt: Date { get }
    var show: Show { get }
}
