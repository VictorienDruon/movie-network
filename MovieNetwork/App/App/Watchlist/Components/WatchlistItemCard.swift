//
//  WatchlistItemCard.swift
//  MovieNetwork
//
//  Created by Victorien Druon on 25/03/2024.
//

import SwiftUI

struct WatchlistItemCard: View {
    var show: Show
    var width: CGFloat

    var body: some View {
        ScrollView {
            VStack(spacing: 28) {
                ShowPoster(
                    show: show,
                    variant: .actions {},
                    size: .custom(width)
                )
                .id("top")

                VStack(spacing: 8) {
                    Title2(show.title)
                        .multilineTextAlignment(.center)
                    ShowMetadata(show: show)
                }

                if let overview = show.overview {
                    Text(overview)
                        .fontDesign(.rounded)
                        .foregroundStyle(.neutral8)
                        .lineLimit(12)
                        .multilineTextAlignment(.center)
                }
            }
            .frame(width: width)
            .padding(.horizontal, 32)
        }
        .padding(.horizontal, -32)
        .contentMargins(.top, 16)
        .contentMargins(.bottom, 96)
        .visualEffect { content, proxy in
            content
                .offset(y: min(abs(144 * (proxy.frame(in: .scrollView).midX / proxy.size.width) - 72), 72))
        }
    }
}

#Preview {
    GeometryReader { screen in
        ScrollView {
            ScrollView(.horizontal) {
                WatchlistItemCard(show: sampleMovie.toShow(), width: screen.size.width - 128)
            }
            .safeAreaPadding(.horizontal, 64)
            .scrollIndicators(.hidden)
        }
        .contentMargins(.vertical, 16)
        .scrollIndicators(.hidden)
    }
}
