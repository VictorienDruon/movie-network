//
//  ShowToolbar.swift
//  MovieNetwork
//
//  Created by Victorien Druon on 09/03/2024.
//

import SwiftUI

struct ShowToolbar: ToolbarContent {
    @EnvironmentObject var viewModel: ShowViewModel

    var body: some ToolbarContent {
        ToolbarItem {
            Menu("More", systemImage: "ellipsis.circle") {
                ShareLink(
                    item: viewModel.show.link,
                    preview: SharePreview(
                        viewModel.show.title,
                        image: Image(uiImage: UIImage(named: "AppIcon") ?? UIImage())
                    )
                )
            }
        }
    }
}

#Preview {
    NavigationStack {
        ScrollView {}
            .navigationTitle("Test")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar { ShowToolbar() }
            .environmentObject(ShowViewModel(for: sampleMovie.toShow()))
    }
}
