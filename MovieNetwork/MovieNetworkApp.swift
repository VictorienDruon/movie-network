//
//  MovieNetworkApp.swift
//  MovieNetwork
//
//  Created by Victorien Druon on 17/02/2024.
//

import SwiftData
import SwiftUI

@main
struct MovieNetworkApp: App {
    var body: some Scene {
        WindowGroup {
            RootView()
        }
        .modelContainer(for: [LocalWatchlistItem.self, LocalReview.self])
    }
}
