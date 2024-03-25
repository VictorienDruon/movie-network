//
//  WatchlistsControls.swift
//  MovieNetwork
//
//  Created by Victorien Druon on 25/03/2024.
//

import SwiftUI

struct WatchlistsControls: View {
    @EnvironmentObject var viewModel: WatchlistViewModel

    var body: some View {
        let filterButtonVariant: ButtonVariant = viewModel.isFiltered
            ? .primaryOutline
            : .secondaryOutline
        let filterButtonTitle = viewModel.isFiltered
            ? String(viewModel.numberOfFilters)
            : "Filter"
        let shuffleButtonVariant: ButtonVariant = viewModel.isShuffled
            ? .primaryOutline
            : .secondaryOutline

        HStack {
            Button(filterButtonTitle, systemImage: "line.3.horizontal.decrease.circle.fill") {
                viewModel.showingFilters = true
            }
            .labelStyle(LabelLayout(.left, .medium))
            .buttonStyle(StyledButton(filterButtonVariant, .medium))

            Button("Shuffle", systemImage: "shuffle") {
                viewModel.isShuffled.toggle()
            }
            .labelStyle(.iconOnly)
            .buttonStyle(StyledButton(shuffleButtonVariant, .medium, iconOnly: true))
            .sensoryFeedback(.selection, trigger: viewModel.isShuffled)
        }
        .padding()
    }
}

#Preview {
    WatchlistsControls()
        .environmentObject(WatchlistViewModel())
}
