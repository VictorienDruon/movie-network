//
//  DiscoverView.swift
//  MovieNetwork
//
//  Created by Victorien Druon on 18/02/2024.
//

import SwiftUI

struct DiscoverView: View {
    @EnvironmentObject var navigation: NavigationManager
    @StateObject var viewModel = DiscoverViewModel()

    var body: some View {
        NavigationStack(path: $navigation.discoverStack) {
            ScrollView {
                VStack {
                    DiscoverFiltersControls()
                }
                .padding(.vertical)
            }
            .scrollIndicators(.hidden)
            .navigationTitle("Discover")
            .toolbar { ProfileToolbar() }
            .environmentObject(DiscoverViewModel())
        }
    }
}

#Preview {
    DiscoverView()
        .environmentObject(NavigationManager())
}
