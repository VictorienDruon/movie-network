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
        ZStack(alignment: .bottom) {
            GeometryReader { screen in
                ScrollView {
                    ScrollViewReader { _ in
                        ScrollView(.horizontal) {
                            LazyHStack(alignment: .top, spacing: 28) {
                                ForEach(viewModel.filteredWatchlist) { show in
                                    WatchlistItemCard(show: show, width: screen.size.width - 112)
                                        .scrollTransition(.animated, axis: .horizontal) { content, phase in
                                            content
                                                .offset(y: phase.isIdentity ? 0 : 72)
                                        }
                                }
                            }
                            .scrollTargetLayout()
                        }
                        .contentMargins(.horizontal, 56)
                        .scrollIndicators(.hidden)
                        .scrollTargetBehavior(.viewAligned)
//                        .onChange(of: viewModel.shows) {
//                            reader.scrollTo(Self.topId)
//                        }
                    }
                }
                .contentMargins(.top, 16)
                .contentMargins(.bottom, 64)
                .scrollIndicators(.hidden)
            }

            WatchlistsControls()
        }
        .sheet(isPresented: $viewModel.showingFilters) {
            WatchlistFilters()
        }
        .environmentObject(viewModel)
        .task { viewModel.getWatchlist() }
    }
}

// #Preview {
//    @StateObject var navigation = NavigationManager()
//
//    return
//        TabView {
//            NavigationStack(path: $navigation.watchlistStack) {
//                Tab.watchlist.view
//                    .navigationTitle(Tab.watchlist.name)
//                    .navigationBarTitleDisplayMode(.large)
//                    .navigationDestination(for: Destination.self, destination: navigation.routeTo)
//                    .toolbar { ProfileTrigger() }
//            }
//            .tag(Tab.watchlist)
//            .tabItem { Image(systemName: Tab.watchlist.icon) }
//        }
// }
