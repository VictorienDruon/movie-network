//
//  ShowTrailer.swift
//  MovieNetwork
//
//  Created by Victorien Druon on 08/03/2024.
//

import SwiftUI

struct ShowTrailer: View {
    @EnvironmentObject var viewModel: ShowViewModel

    var body: some View {
        ZStack {
            if let key = viewModel.show.videos?.trailerKey, viewModel.showingTrailer {
                BackdropVideo(key: key, size: .full)
            } else {
                BackdropWithAction(
                    url: viewModel.show.backdropUrl(.w1280),
                    size: .full,
                    disabled: viewModel.show.videos?.trailerKey == nil
                ) {
                    withAnimation {
                        viewModel.showingTrailer = true
                    }
                }
            }
        }
        .transition(.opacity)
        .padding(.horizontal)
    }
}

#Preview {
    ShowTrailer()
        .environmentObject(ShowViewModel(for: sampleMovie.toShow()))
}
