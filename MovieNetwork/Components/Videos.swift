//
//  Videos.swift
//  MovieNetwork
//
//  Created by Victorien Druon on 08/03/2024.
//

import SwiftUI
import YouTubePlayerKit

private let config = YouTubePlayer.Configuration(
    autoPlay: true,
    showCaptions: false,
    loopEnabled: true,
    useModestBranding: true
)

struct Video: View {
    var key: String
    var youTubePlayer: YouTubePlayer {
        YouTubePlayer(source: .video(id: key), configuration: config)
    }

    var body: some View {
        YouTubePlayerView(youTubePlayer) { state in
            switch state {
            case .ready: EmptyView()
            default: Color.neutral9
            }
        }
    }
}

struct RectVideo: View {
    var key: String
    var aspectRatio: AspectRatio
    var width: CGFloat?
    var radius: CGFloat = 0
    var height: CGFloat? {
        if let width { return width * 1 / aspectRatio.value }
        else { return nil }
    }

    var body: some View {
        Video(key: key)
            .aspectRatio(aspectRatio.value, contentMode: .fit)
            .frame(width: width, height: height)
            .clipShape(RoundedRectangle(cornerRadius: radius))
    }
}
