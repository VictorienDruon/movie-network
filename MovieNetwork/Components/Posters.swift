//
//  Posters.swift
//  MovieNetwork
//
//  Created by Victorien Druon on 05/03/2024.
//

import SwiftUI

struct Poster: View {
    var url: URL?
    var size: PosterSize

    var body: some View {
        RectImage(
            url: url,
            aspectRatio: .poster,
            width: size.config.width,
            radius: size.config.radius
        )
        .shadowSize(size.config.shadowSize)
    }
}

struct PosterWithTopTitle: View {
    var title: String
    var url: URL?
    var size: PosterSize

    var body: some View {
        ZStack(alignment: .top) {
            Poster(url: url, size: size)

            Text(title)
                .font(.system(size: size.config.titleFontSize, weight: .bold, design: .rounded))
                .foregroundStyle(.white)
                .lineLimit(1)
                .padding(.horizontal, size.config.titlePadding)
                .frame(height: size.config.titleHeight)
                .background(.ultraThinMaterial, in: Capsule())
                .padding(size.config.titlePadding)
                .shadowSize(.small)
        }
        .frame(width: size.config.width)
    }
}

struct PosterWithBottomTitle: View {
    var title: String
    var url: URL?
    var size: PosterSize

    var body: some View {
        VStack(spacing: size.config.titlePadding) {
            Poster(url: url, size: size)

            Text(title)
                .font(.system(size: size.config.titleFontSize, design: .rounded))
                .foregroundStyle(.neutral11)
                .lineLimit(2)
                .multilineTextAlignment(.center)
        }
        .frame(width: size.config.width)
    }
}

struct PosterWithActions: View {
    var url: URL?
    var size: PosterSize
    var onPlay: () -> Void
    var onShare: () -> Void

    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            Poster(url: url, size: size)

            HStack(spacing: size.config.titlePadding / 2) {
                Button("Play", systemImage: "play.fill", action: onPlay)
                    .buttonStyle(TransparentButton(size.config.buttonSize, iconOnly: true))
                    .labelStyle(.iconOnly)

                Button("Share", systemImage: "square.and.arrow.up", action: onShare)
                    .buttonStyle(TransparentButton(size.config.buttonSize, iconOnly: true))
                    .labelStyle(.iconOnly)
            }
            .padding(size.config.titlePadding)
        }
    }
}

struct ShowPoster: View {
    var show: Show
    var variant = PosterVariant.topTitle
    var size = PosterSize.medium
    var withNavigation = false

    var body: some View {
        let poster = switch variant {
        case .raw:
            AnyView(Poster(
                url: show.posterUrl(size.config.imageSize),
                size: size
            ))
        case .topTitle:
            AnyView(PosterWithTopTitle(
                title: show.title,
                url: show.posterUrl(size.config.imageSize),
                size: size
            ))
        case .bottomTitle:
            AnyView(PosterWithBottomTitle(
                title: show.title,
                url: show.posterUrl(size.config.imageSize),
                size: size
            ))
        }

        if withNavigation {
            NavigationLink(value: Destination.show(show)) {
                poster
            }
            .buttonStyle(Pressable())
        } else {
            poster
        }
    }
}

struct ShowPosters: View {
    var shows: [Show]
    var variant = PosterVariant.topTitle
    var size = PosterSize.medium
    var withNavigation = true

    var body: some View {
        ScrollView(.horizontal) {
            HStack(alignment: .top, spacing: 12) {
                ForEach(shows) { show in
                    ShowPoster(
                        show: show,
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

enum PosterVariant {
    case raw, topTitle, bottomTitle
}

enum PosterSize {
    case small, medium, large

    var config: PosterConfig {
        switch self {
        case .small:
            PosterConfig(
                width: 120,
                radius: 14,
                titleHeight: 20,
                titlePadding: 6,
                titleFontSize: 12,
                buttonSize: .small,
                shadowSize: .small,
                imageSize: .w342
            )
        case .medium:
            PosterConfig(
                width: 150,
                radius: 16,
                titleHeight: 26,
                titlePadding: 8,
                titleFontSize: 14,
                buttonSize: .medium,
                shadowSize: .medium,
                imageSize: .w500
            )
        case .large:
            PosterConfig(
                width: 250,
                radius: 24,
                titleHeight: 32,
                titlePadding: 12,
                titleFontSize: 20,
                buttonSize: .large,
                shadowSize: .large,
                imageSize: .w780
            )
        }
    }
}

struct PosterConfig {
    var width: CGFloat
    var radius: CGFloat
    var titleHeight: CGFloat
    var titlePadding: CGFloat
    var titleFontSize: CGFloat
    var buttonSize: ButtonSize
    var shadowSize: ShadowSize
    var imageSize: PosterImageSize
}

#Preview {
    VStack {
        PosterWithTopTitle(title: sampleMovie.title, url: sampleMovie.posterUrl(.w780), size: .small)
        PosterWithBottomTitle(title: sampleMovie.title, url: sampleMovie.posterUrl(.w780), size: .small)
        PosterWithActions(url: sampleMovie.posterUrl(.w780), size: .small, onPlay: {}, onShare: {})
    }
}
