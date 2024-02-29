//
//  DiscoverView.swift
//  MovieNetwork
//
//  Created by Victorien Druon on 18/02/2024.
//

import SwiftUI

struct DiscoverView: View {
    @EnvironmentObject var navigation: Navigation

    var body: some View {
        NavigationStack(path: $navigation.discoverStack) {
            Text("Discover")
                .navigationTitle("Discover")
                .toolbar {
                    ProfileToolbar()
                }
        }
    }
}

#Preview {
    DiscoverView()
        .environmentObject(Navigation())
}
