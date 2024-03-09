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
