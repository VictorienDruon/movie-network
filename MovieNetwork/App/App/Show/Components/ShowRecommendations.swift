//
//  ShowRecommendations.swift
//  MovieNetwork
//
//  Created by Victorien Druon on 20/03/2024.
//

import SwiftUI

struct ShowRecommendations: View {
    @EnvironmentObject var viewModel: ShowViewModel

    var body: some View {
        if let recommendations = viewModel.show.recommendations, !recommendations.isEmpty {
            Section("Recommendations") {
                ShowPosters(shows: recommendations, variant: .bottomTitle, size: .small)
            }
        }
    }
}

#Preview {
    ShowRecommendations()
        .environmentObject(ShowViewModel(for: sampleMovie.toShow()))
}
