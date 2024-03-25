//
//  WatchlistFilters.swift
//  MovieNetwork
//
//  Created by Victorien Druon on 25/03/2024.
//

import SwiftUI
import WrappingHStack

struct WatchlistFilters: View {
    @EnvironmentObject var viewModel: WatchlistViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: 32) {
            HStack {
                Button("", systemImage: "xmark") {}
                    .labelStyle(.iconOnly)
                    .buttonStyle(StyledButton(.secondaryOutline, .small, iconOnly: true))
                    .hidden()
                Spacer()
                Headline("Filters")
                Spacer()
                Button("Close", systemImage: "xmark") {
                    viewModel.showingFilters = false
                }
                .labelStyle(.iconOnly)
                .buttonStyle(StyledButton(.secondaryOutline, .small, iconOnly: true))
            }

            VStack(alignment: .leading, spacing: 12) {
                Title3("Type")
                HStack(spacing: 12) {
                    ForEach(ShowType.allCases) { type in
                        let variant: ButtonVariant = viewModel.typeFilters.contains(type)
                            ? .primary
                            : .secondaryOutline

                        Button(type.name) {
                            viewModel.typeFilters.toggle(type)
                        }
                        .buttonStyle(StyledButton(variant, .small))
                    }
                }
            }
            .sensoryFeedback(.selection, trigger: viewModel.typeFilters)

            VStack(alignment: .leading, spacing: 12) {
                Title3("Genre")
                WrappingHStack(alignment: .leading, horizontalSpacing: 12, verticalSpacing: 12) {
                    ForEach(genresList) { genre in
                        let variant: ButtonVariant = viewModel.genreFilters.contains(genre)
                            ? .primary
                            : .secondaryOutline

                        Button("\(genre.emoji) \(genre.name)") {
                            viewModel.genreFilters.toggle(genre)
                        }
                        .buttonStyle(StyledButton(variant, .small))
                    }
                }
            }
            .sensoryFeedback(.selection, trigger: viewModel.genreFilters)

            Spacer()
        }
        .padding(.horizontal)
        .padding(.top)
        .presentationDetents([.fraction(3/4)])
    }
}

#Preview {
    VStack {}
        .sheet(isPresented: .constant(true)) {
            WatchlistFilters()
        }
        .environmentObject(WatchlistViewModel())
}
