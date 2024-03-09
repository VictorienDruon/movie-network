//
//  Job.swift
//  MovieNetwork
//
//  Created by Victorien Druon on 09/03/2024.
//

import Foundation

struct Job: Codable, Equatable, Hashable {
    let creditID: String
    let job: String
    
    init(creditID: String, job: String) {
        self.creditID = creditID
        self.job = job
    }
}

extension Job {
    private enum CodingKeys: String, CodingKey {
        case creditID = "creditId"
        case job
    }
}
