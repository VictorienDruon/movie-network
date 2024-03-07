//
//  PersonViewModel.swift
//  MovieNetwork
//
//  Created by Victorien Druon on 07/03/2024.
//

import Foundation

@MainActor
final class PersonViewModel: ObservableObject {
    @Published var person: Person

    init(person: Person) {
        self.person = person
    }
}
