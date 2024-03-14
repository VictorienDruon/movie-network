//
//  MediaRow.swift
//  MovieNetwork
//
//  Created by Victorien Druon on 13/03/2024.
//

import SwiftUI

struct MediaRow: View {
    var media: Media

    var destination: Destination {
        switch media {
        case let .movie(movie):.show(movie.toShow())
        case let .tvSeries(tvSeries): .show(tvSeries.toShow())
        case let .person(person): .person(person)
        }
    }

    @ViewBuilder
    var asset: some View {
        switch media {
        case let .movie(movie):
            ShowBackdrop(show: movie.toShow(), variant: .raw, size: .small, withNavigation: false)
        case let .tvSeries(tvSeries):
            ShowBackdrop(show: tvSeries.toShow(), variant: .raw, size: .small, withNavigation: false)
        case let .person(person):
            PersonThumbnail(person: person, variant: .raw, size: .small, withNavigation: false)
        }
    }

    var title: String {
        switch media {
        case let .movie(movie): movie.title
        case let .tvSeries(tvSeries): tvSeries.name
        case let .person(person): person.name
        }
    }

    var subtitle: String? {
        switch media {
        case let .movie(movie):
            if let releaseDate = movie.releaseDate {
                return getYear(from: releaseDate)
            } else { return nil }
        case let .tvSeries(tvSeries):
            if let firstAirDate = tvSeries.firstAirDate {
                return getYear(from: firstAirDate)
            } else { return nil }
        case .person: return nil
        }
    }

    var body: some View {
        NavigationLink(value: destination) {
            HStack(spacing: 16) {
                asset

                VStack(alignment: .leading, spacing: 4) {
                    Headline(title)
                        .lineLimit(2)

                    if let subtitle {
                        Text(subtitle)
                            .font(.callout)
                            .fontWeight(.medium)
                            .fontDesign(.rounded)
                            .foregroundStyle(.neutral8)
                            .lineLimit(1)
                    }
                }
            }
        }
    }
}

#Preview {
    MediaRow(media: sampleMovie.toMedia())
}
