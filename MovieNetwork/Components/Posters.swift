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
        RectImage(url: url, aspectRatio: .poster, width: size.config.width, radius: size.config.radius)
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
                .font(.system(size: size.config.titleFontSize, weight: .bold))
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
                .font(.system(size: size.config.titleFontSize))
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

struct ShowPostersList: View {
    var shows: [Show]
    var variant: PosterVariant = .topTitle
    var size: PosterSize = .medium

    var body: some View {
        ScrollView(.horizontal) {
            HStack(alignment: .top) {
                ForEach(shows) { show in
                    switch variant {
                    case .raw:
                        Poster(url: show.posterUrl(size.config.imageSize), size: size)
                    case .topTitle:
                        PosterWithTopTitle(title: show.title, url: show.posterUrl(size.config.imageSize), size: size)
                    case .bottomTitle:
                        PosterWithBottomTitle(title: show.title, url: show.posterUrl(size.config.imageSize), size: size)
                    }
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
    let test = Movie(
        id: 792307,
        title: "Poor Things",
        posterPath: URL(string: "/kCGlIMHnOm8JPXq3rXM6c5wMxcT.jpg")
    )

    return VStack {
        PosterWithTopTitle(title: test.title, url: test.posterUrl(.w780), size: .small)
        PosterWithBottomTitle(title: test.title, url: test.posterUrl(.w780), size: .small)
        PosterWithActions(url: test.posterUrl(.w780), size: .small, onPlay: {}, onShare: {})
    }
}