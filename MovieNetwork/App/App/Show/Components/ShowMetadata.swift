//
//  ShowMetadata.swift
//  MovieNetwork
//
//  Created by Victorien Druon on 25/03/2024.
//

import SwiftUI

struct ShowMetadata: View {
    var show: Show

    var metadata: [String] {
        var metadataArray: [String] = []

        if let releaseDate = show.releaseDate {
            metadataArray.append(getYear(from: releaseDate))
        }

        switch show {
        case let .movie(movie):
            if let runtime = movie.runtime, runtime != 0 {
                metadataArray.append(formatDuration(runtime))
            }
        case let .tvSeries(tvSeries):
            if let numberOfSeasons = tvSeries.numberOfSeasons, numberOfSeasons != 0 {
                metadataArray.append("\(numberOfSeasons) \(pluralize("season", from: numberOfSeasons))")
            }
        }

        if let voteAverage = show.voteAverage, voteAverage != 0 {
            metadataArray.append(String(format: "%.1f", voteAverage))
        }

        return metadataArray
    }

    var body: some View {
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
}

#Preview {
    ShowMetadata(show: sampleMovie.toShow())
}
