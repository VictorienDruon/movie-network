//
//  Role.swift
//  MovieNetwork
//
//  Created by Victorien Druon on 09/03/2024.
//

import Foundation

struct Role: Codable, Equatable, Hashable {
    let creditID: String
    let character: String
    
    init(creditID: String, character: String) {
        self.creditID = creditID
        self.character = character
    }
}

extension Role {
    private enum CodingKeys: String, CodingKey {
        case creditID = "creditId"
        case character
    }
}
