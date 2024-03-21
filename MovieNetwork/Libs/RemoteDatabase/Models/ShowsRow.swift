//
//  ShowsRow.swift
//  MovieNetwork
//
//  Created by Victorien Druon on 16/03/2024.
//

import Foundation

struct ShowsRow: Codable {
    let id: String
    
    private enum CodingKeys: String, CodingKey {
        case id
    }
}
