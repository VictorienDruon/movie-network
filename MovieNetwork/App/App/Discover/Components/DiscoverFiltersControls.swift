//
//  DiscoverFilters.swift
//  MovieNetwork
//
//  Created by Victorien Druon on 29/02/2024.
//

import SwiftUI

struct DiscoverFiltersControls: View {
    @EnvironmentObject var viewModel: DiscoverViewModel

    var body: some View {
        let genreMenuName = viewModel.selectedGenre?.name ?? "Genre"
        let genreMenuVariant: ButtonVariant = viewModel.selectedGenre != nil
            ? .primary
            : .secondaryOutline

        HStack(spacing: 8) {
            ForEach(ShowType.allCases) { showType in
                let variant: ButtonVariant = viewModel.showTypeFilters.contains(showType)
                    ? .primary
                    : .secondaryOutline

                Button(showType.name) {
                    viewModel.showTypeFilters.toggle(showType)
                }
                .buttonStyle(StyledButton(variant, .small))
            }

            Menu(genreMenuName, systemImage: "chevron.down") {
                ForEach(genresList) { genre in
                    if viewModel.selectedGenre == genre {
                        Button(genre.name, systemImage: "checkmark") {
                            viewModel.selectedGenre = nil
                        }
                    } else {
                        Button(genre.name) {
                            viewModel.selectedGenre = genre
                        }
                    }
                }
            }
            .buttonStyle(StyledButton(genreMenuVariant, .small))
            .labelStyle(LabelLayout(.right, .small))

            Spacer()
        }
        .padding(.horizontal)
    }
}

#Preview {
    DiscoverFiltersControls()
        .environmentObject(DiscoverViewModel())
}
