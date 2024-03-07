//
//  Thumbnails.swift
//  MovieNetwork
//
//  Created by Victorien Druon on 07/03/2024.
//

import SwiftUI

struct Thumbnail: View {
    var url: URL?
    var size: ThumbnailSize

    var body: some View {
        CircleImage(url: url, size: size.config.width)
            .shadowSize(size.config.shadowSize)
    }
}

struct ThumbnailWithName: View {
    var name: String
    var description: String?
    var url: URL?
    var size: ThumbnailSize

    var body: some View {
        VStack {
            Thumbnail(url: url, size: size)

            Text(name)
                .font(.system(size: size.config.nameFontSize))
                .lineLimit(2)
                .multilineTextAlignment(.center)

            if let description {
                Text(description)
                    .font(.system(size: size.config.descriptionFontSize))
                    .foregroundStyle(.neutral8)
                    .lineLimit(1)
            }
        }
        .frame(width: size.config.width)
    }
}

struct PersonThumbnailsList: View {
    var people: [Person]
    var variant: ThumbnailVariant = .name
    var size: ThumbnailSize = .medium

    var body: some View {
        ScrollView(.horizontal) {
            HStack(alignment: .top) {
                ForEach(people) { person in
                    switch variant {
                    case .raw:
                        Thumbnail(url: person.profileUrl(size.config.imageSize), size: size)
                    case .name:
                        ThumbnailWithName(name: person.name, url: person.profileUrl(size.config.imageSize), size: size)
                    }
                }
            }
            .padding(.vertical, 32)
        }
        .padding(.vertical, -32)
        .contentMargins(.horizontal, 16)
    }
}

enum ThumbnailVariant {
    case raw, name
}

enum ThumbnailSize {
    case small, medium, large

    var config: ThumbnailConfig {
        switch self {
        case .small:
            ThumbnailConfig(
                width: 64,
                nameFontSize: 12,
                descriptionFontSize: 8,
                shadowSize: .small,
                imageSize: .w185
            )
        case .medium:
            ThumbnailConfig(
                width: 96,
                nameFontSize: 14,
                descriptionFontSize: 12,
                shadowSize: .small,
                imageSize: .h632
            )
        case .large:
            ThumbnailConfig(
                width: 128,
                nameFontSize: 20,
                descriptionFontSize: 14,
                shadowSize: .small,
                imageSize: .original
            )
        }
    }
}

struct ThumbnailConfig {
    var width: CGFloat
    var nameFontSize: CGFloat
    var descriptionFontSize: CGFloat
    var shadowSize: ShadowSize
    var imageSize: ProfileImageSize
}

#Preview {
    let test = Person(
        id: 115440,
        name: "Sydney Sweeney",
        gender: .female,
        profilePath: URL(string: "/qYiaSl0Eb7G3VaxOg8PxExCFwon.jpg")!
    )

    return
        ThumbnailWithName(
            name: test.name,
            description: "Snake",
            url: test.profileUrl(.h632),
            size: .medium
        )
}