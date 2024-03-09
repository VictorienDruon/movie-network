//
//  ShowGenres.swift
//  MovieNetwork
//
//  Created by Victorien Druon on 09/03/2024.
//

import SwiftUI

struct ShowGenres: View {
    @EnvironmentObject var viewModel: ShowViewModel

    var body: some View {
        if let genres = viewModel.show.genres, !genres.isEmpty {
            ScrollView(.horizontal) {
                LazyHStack {
                    ForEach(genres) { genre in
                        Tag(genre.name, size: .small)
                    }
                }
            }
            .contentMargins(.horizontal, 16)
        }
    }
}

#Preview {
    ShowGenres()
        .environmentObject(ShowViewModel(for: sampleMovie.toShow()))
}
