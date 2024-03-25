//
//  Numbers.swift
//  MovieNetwork
//
//  Created by Victorien Druon on 09/03/2024.
//

import Foundation

func formatDuration(_ duration: Int) -> String {
    let hours = duration / 60
    let minutes = duration % 60
    if hours > 0 {
        return "\(hours)h \(minutes)m"
    } else {
        return "\(minutes)m"
    }
}

func extractIntegers(string: String?) -> [Int]? {
    guard let string, !string.isEmpty else {
        return nil
    }
    let components = string.split(separator: ",")
    return components.compactMap { Int($0) }
}

extension Array where Element == Int {
    func joined(separator: String) -> String {
        let stringArray = self.map { String($0) }
        return stringArray.joined(separator: separator)
    }
}
