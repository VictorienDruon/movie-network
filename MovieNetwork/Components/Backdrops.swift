//
//  Backdrops.swift
//  MovieNetwork
//
//  Created by Victorien Druon on 08/03/2024.
//

import SwiftUI

struct Backdrop: View {
    var url: URL?
    var size: BackdropSize

    var body: some View {
        RectImage(
            url: url,
            aspectRatio: .backdrop,
            width: size.config.width,
            radius: size.config.radius
        )
        .shadowSize(size.config.shadowSize)
    }
}

struct BackdropWithAction: View {
    var url: URL?
    var size: BackdropSize
    var disabled: Bool = false
    var onPlay: () -> Void

    var body: some View {
        ZStack {
            Backdrop(url: url, size: size)

            if !disabled {
                Button("Play", systemImage: "play.fill", action: onPlay)
                    .buttonStyle(TransparentButton(size.config.buttonSize, iconOnly: true))
                    .labelStyle(.iconOnly)
            }
        }
    }
}

struct BackdropVideo: View {
    var key: String
    var size: BackdropSize

    var body: some View {
        RectVideo(
            key: key,
            aspectRatio: .backdrop,
            width: size.config.width,
            radius: size.config.radius
        )
        .shadowSize(size.config.shadowSize)
    }
}

enum BackdropSize {
    case small, medium, large, full

    var config: BackdropConfig {
        switch self {
        case .small:
            return BackdropConfig(
                width: 120,
                radius: 14,
                buttonSize: .small,
                shadowSize: .small
            )
        case .medium:
            return BackdropConfig(
                width: 150,
                radius: 16,
                buttonSize: .medium,
                shadowSize: .medium
            )
        case .large:
            return BackdropConfig(
                width: 250,
                radius: 24,
                buttonSize: .large,
                shadowSize: .large
            )
        case .full:
            var largeConfig = BackdropSize.large.config
            largeConfig.width = nil
            return largeConfig
        }
    }
}

struct BackdropConfig {
    var width: CGFloat?
    var radius: CGFloat
    var buttonSize: ButtonSize
    var shadowSize: ShadowSize
}

#Preview {
    VStack {
        Backdrop(url: sampleMovie.backdropUrl(.original), size: .large)
        BackdropWithAction(url: sampleMovie.backdropUrl(.original), size: .large) {}
    }
}
