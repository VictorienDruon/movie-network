//
//  WatchlisthView.swift
//  MovieNetwork
//
//  Created by Victorien Druon on 18/02/2024.
//

import SwiftUI

struct WatchlisthView: View {
    @EnvironmentObject var navigation: NavigationManager
    
    var body: some View {
        NavigationStack(path: $navigation.watchlistStack) {
            Title3("Watchlist")
                .navigationTitle("Watchlist")
                .navigationDestination(for: Destination.self, destination: navigation.routeTo)
                .toolbar {
                    ProfileToolbar()
                }
        }
    }
}

#Preview {
    WatchlisthView()
        .environmentObject(NavigationManager())
}
