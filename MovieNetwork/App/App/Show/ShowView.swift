//
//  ShowView.swift
//  MovieNetwork
//
//  Created by Victorien Druon on 07/03/2024.
//

import SwiftUI

struct ShowView: View {
    @StateObject private var viewModel: ShowViewModel

    init(for show: Show) {
        _viewModel = StateObject(wrappedValue: ShowViewModel(for: show))
    }

    var body: some View {
        ScrollView {
            LazyVStack(spacing: 32) {
                LazyVStack(alignment: .leading, spacing: 16) {
                    ShowTrailer()
                    ShowHeader()
                    ShowGenres()
                    ShowControls()
                }
                NeutralDivider()
                ShowOverview()
                ShowRecommendations()
                ShowCast()
                ShowCrew()
            }
        }
        .contentMargins(.vertical, 16)
        .scrollIndicators(.hidden)
        .navigationTitle(viewModel.show.title)
        .navigationBarTitleDisplayMode(.inline)
        .sheet(isPresented: $viewModel.showingReviewForm) {
            ShowReviewForm()
        }
        .toolbar {
            ShowToolbar()
        }
        .environmentObject(viewModel)
    }
}

// #Preview {
//    ShowView(for: sampleMovie.toShow())
// }
