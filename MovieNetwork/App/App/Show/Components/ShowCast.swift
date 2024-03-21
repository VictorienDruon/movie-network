//
//  ShowCast.swift
//  MovieNetwork
//
//  Created by Victorien Druon on 20/03/2024.
//

import SwiftUI

struct ShowCast: View {
    @EnvironmentObject var viewModel: ShowViewModel

    var body: some View {
        if let cast = viewModel.cast, !cast.isEmpty {
            Section("Cast") {
                CastThumbnails(cast: cast)
            }
        }
    }
}

#Preview {
    ShowCast()
        .environmentObject(ShowViewModel(for: sampleMovie.toShow()))
}
