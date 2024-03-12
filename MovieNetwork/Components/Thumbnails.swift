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
                .font(.system(size: size.config.nameFontSize, design: .rounded))
                .foregroundStyle(.neutral11)
                .lineLimit(2)
                .multilineTextAlignment(.center)

            if let description {
                Text(description)
                    .font(.system(size: size.config.descriptionFontSize, design: .rounded))
                    .foregroundStyle(.neutral8)
                    .lineLimit(1)
            }
        }
        .frame(width: size.config.width)
    }
}

struct PersonThumbnail: View {
    var person: Person
    var variant = ThumbnailVariant.name
    var size = ThumbnailSize.medium
    var withNavigation = true

    @ViewBuilder
    var thumbnail: some View {
        switch variant {
        case .raw:
            Thumbnail(
                url: person.profileUrl(size.config.imageSize),
                size: size
            )
        case .name:
            ThumbnailWithName(
                name: person.name,
                url: person.profileUrl(size.config.imageSize),
                size: size
            )
        }
    }

    var body: some View {
        if withNavigation {
            NavigationLink(value: Destination.person(person)) {
                thumbnail
            }
            .buttonStyle(Pressable())
        } else {
            thumbnail
        }
    }
}

struct PersonThumbnails: View {
    var people: [Person]
    var variant = ThumbnailVariant.name
    var size = ThumbnailSize.medium
    var withNavigation = true

    var body: some View {
        ScrollView(.horizontal) {
            LazyHStack(alignment: .top, spacing: 12) {
                ForEach(people) { person in
                    PersonThumbnail(
                        person: person,
                        variant: variant,
                        size: size,
                        withNavigation: withNavigation
                    )
                }
            }
            .padding(.vertical, 32)
        }
        .padding(.vertical, -32)
        .contentMargins(.horizontal, 16)
    }
}

struct CastThumbnail: View {
    var member: CastMember
    var variant = ThumbnailVariant.name
    var size = ThumbnailSize.medium
    var withNavigation = true

    @ViewBuilder
    var thumbnail: some View {
        switch variant {
        case .raw:
            Thumbnail(
                url: member.profileUrl(size.config.imageSize),
                size: size
            )
        case .name:
            ThumbnailWithName(
                name: member.name,
                description: member.character ?? member.roles?.first?.character,
                url: member.profileUrl(size.config.imageSize),
                size: size
            )
        }
    }

    var body: some View {
        if withNavigation {
            NavigationLink(value: Destination.person(member.toPerson())) {
                thumbnail
            }
            .buttonStyle(Pressable())
        } else {
            thumbnail
        }
    }
}

struct CastThumbnails: View {
    var cast: [CastMember]
    var variant = ThumbnailVariant.name
    var size = ThumbnailSize.medium
    var withNavigation = true

    var body: some View {
        ScrollView(.horizontal) {
            LazyHStack(alignment: .top, spacing: 12) {
                ForEach(cast) { member in
                    CastThumbnail(
                        member: member,
                        variant: variant,
                        size: size,
                        withNavigation: withNavigation
                    )
                }
            }
            .padding(.vertical, 32)
        }
        .padding(.vertical, -32)
        .contentMargins(.horizontal, 16)
    }
}

struct CrewThumbnail: View {
    var member: CrewMember
    var variant = ThumbnailVariant.name
    var size = ThumbnailSize.medium
    var withNavigation = true

    @ViewBuilder
    var thumbnail: some View {
        switch variant {
        case .raw:
            Thumbnail(
                url: member.profileUrl(size.config.imageSize),
                size: size
            )
        case .name:
            ThumbnailWithName(
                name: member.name,
                description: member.job ?? member.jobs?.first?.job,
                url: member.profileUrl(size.config.imageSize),
                size: size
            )
        }
    }

    var body: some View {
        if withNavigation {
            NavigationLink(value: Destination.person(member.toPerson())) {
                thumbnail
            }
            .buttonStyle(Pressable())
        } else {
            thumbnail
        }
    }
}

struct CrewThumbnails: View {
    var crew: [CrewMember]
    var variant = ThumbnailVariant.name
    var size = ThumbnailSize.medium
    var withNavigation = true

    var body: some View {
        ScrollView(.horizontal) {
            LazyHStack(alignment: .top, spacing: 12) {
                ForEach(crew) { member in
                    CrewThumbnail(
                        member: member,
                        variant: variant,
                        size: size,
                        withNavigation: withNavigation
                    )
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
    ThumbnailWithName(
        name: sampleCastMember.name,
        description: sampleCastMember.character,
        url: sampleCastMember.profileUrl(.h632),
        size: .medium
    )
}
