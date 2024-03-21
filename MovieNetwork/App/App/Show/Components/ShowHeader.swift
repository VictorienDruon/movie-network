//
//  ShowHeader.swift
//  MovieNetwork
//
//  Created by Victorien Druon on 09/03/2024.
//

import SwiftUI

struct ShowHeader: View {
    @EnvironmentObject var viewModel: ShowViewModel

    var metadata: [String] {
        var metadataArray: [String] = []

        if let releaseDate = viewModel.show.releaseDate {
            metadataArray.append(getYear(from: releaseDate))
        }

        switch viewModel.show {
        case let .movie(movie):
            if let runtime = movie.runtime, runtime != 0 {
                metadataArray.append(formatDuration(runtime))
            }
        case let .tvSeries(tvSeries):
            if let numberOfSeasons = tvSeries.numberOfSeasons, numberOfSeasons != 0 {
                metadataArray.append("\(numberOfSeasons) \(pluralize("season", from: numberOfSeasons))")
            }
        }

        if let voteAverage = viewModel.show.voteAverage, voteAverage != 0 {
            metadataArray.append(String(format: "%.1f", voteAverage))
        }

        return metadataArray
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Title2(viewModel.show.title)

            if !metadata.isEmpty {
                HStack {
                    ForEach(metadata, id: \.self) { item in
                        if item != metadata.first {
                            Text("•")
                                .font(.headline)
                                .fontWeight(.medium)
                                .fontDesign(.rounded)
                                .foregroundStyle(.neutral4)
                        }

                        Text(item)
                            .font(.headline)
                            .fontWeight(.medium)
                            .fontDesign(.rounded)
                            .foregroundStyle(.neutral8)
                    }
                }
            }
        }
        .padding(.horizontal)
    }
}

#Preview {
    ShowHeader()
        .environmentObject(ShowViewModel(for: sampleMovie.toShow()))
}
