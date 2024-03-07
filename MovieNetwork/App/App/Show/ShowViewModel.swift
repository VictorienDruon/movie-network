//
//  ShowViewModel.swift
//  MovieNetwork
//
//  Created by Victorien Druon on 07/03/2024.
//

import Foundation

@MainActor
final class ShowViewModel: ObservableObject {
    @Published var show: Show

    init(show: Show) {
        self.show = show
    }
}
