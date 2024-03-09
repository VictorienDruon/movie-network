//
//  WatchlistControls.swift
//  MovieNetwork
//
//  Created by Victorien Druon on 09/03/2024.
//

import SwiftUI

struct WatchlistControls: View {
    var body: some View {
        Button("Add to watchlist", systemImage: "plus") {}
            .buttonStyle(StyledButton(.primary, .full))
            .padding(.horizontal)
    }
}

#Preview {
    WatchlistControls()
}
