//
//  Arrays.swift
//  MovieNetwork
//
//  Created by Victorien Druon on 29/02/2024.
//

import Foundation

extension Array where Element: Equatable {
    mutating func toggle(_ item: Element) {
        if let index = self.firstIndex(of: item) {
            self.remove(at: index)
        } else {
            self.append(item)
        }
    }
}
