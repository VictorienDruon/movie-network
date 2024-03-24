//
//  WatchlisthView.swift
//  MovieNetwork
//
//  Created by Victorien Druon on 18/02/2024.
//

import SwiftUI

struct WatchlisthView: View {
    @StateObject var viewModel = WatchlistViewModel()

    var body: some View {
        GeometryReader { screen in
            ScrollView {
                ScrollView(.horizontal) {
                    LazyHStack(alignment: .top, spacing: 32) {
                        ForEach(viewModel.shows) { show in
                            var width = screen.size.width - 128

                            VStack(spacing: 32) {
                                ShowPoster(
                                    show: show,
                                    variant: .actions {},
                                    size: .fullScreen
                                )

                                Title2(show.title)

                                if let overview = show.overview {
                                    BodyText(overview)
                                        .lineLimit(12)
                                }
                            }
                            .frame(width: screen.size.width - 128)
                        }
                    }
                    .scrollTargetLayout()
                }
                .safeAreaPadding(.horizontal, 64)
                .scrollTargetBehavior(.viewAligned)
                .scrollIndicators(.hidden)
            }
            .contentMargins(.vertical, 16)
            .scrollIndicators(.hidden)
        }
    }
}

#Preview {
    @StateObject var navigation = NavigationManager()

    return
        TabView {
            NavigationStack(path: $navigation.watchlistStack) {
                Tab.watchlist.view
                    .navigationTitle(Tab.watchlist.name)
                    .navigationBarTitleDisplayMode(.large)
                    .navigationDestination(for: Destination.self, destination: navigation.routeTo)
                    .toolbar { ProfileTrigger() }
            }
            .tag(Tab.watchlist)
            .tabItem { Image(systemName: Tab.watchlist.icon) }
        }
}
