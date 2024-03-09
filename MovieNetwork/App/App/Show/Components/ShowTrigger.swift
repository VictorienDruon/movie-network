//
//  ShowTrigger.swift
//  MovieNetwork
//
//  Created by Victorien Druon on 09/03/2024.
//

import SwiftUI

struct ShowTrigger: ToolbarContent {
    @EnvironmentObject var viewModel: ShowViewModel

    var body: some ToolbarContent {
        ToolbarItem {
            Menu("More", systemImage: "ellipsis.circle") {
                ShareLink(item: viewModel.show.link)
            }
        }
    }
}

#Preview {
    NavigationStack {
        ScrollView {}
            .navigationTitle("Test")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar { ShowTrigger() }
            .environmentObject(ShowViewModel(for: sampleMovie.toShow()))
    }
}
