//
//  ShowOverview.swift
//  MovieNetwork
//
//  Created by Victorien Druon on 20/03/2024.
//

import SwiftUI

struct ShowOverview: View {
    @EnvironmentObject var viewModel: ShowViewModel

    var body: some View {
        if let overview = viewModel.show.overview, !overview.isEmpty {
            TextBlock(title: "Overview", content: overview)
        }
    }
}

#Preview {
    ShowOverview()
        .environmentObject(ShowViewModel(for: sampleMovie.toShow()))
}
