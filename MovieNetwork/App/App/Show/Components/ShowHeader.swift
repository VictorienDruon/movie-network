//
//  ShowHeader.swift
//  MovieNetwork
//
//  Created by Victorien Druon on 09/03/2024.
//

import SwiftUI

struct ShowHeader: View {
    @EnvironmentObject var viewModel: ShowViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Title2(viewModel.show.title)
            ShowMetadata(show: viewModel.show)
        }
        .padding(.horizontal)
    }
}

#Preview {
    ShowHeader()
        .environmentObject(ShowViewModel(for: sampleMovie.toShow()))
}
