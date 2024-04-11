//
//  ShowCrew.swift
//  MovieNetwork
//
//  Created by Victorien Druon on 20/03/2024.
//

import SwiftUI

struct ShowCrew: View {
    @EnvironmentObject var viewModel: ShowViewModel

    var body: some View {
        if let crew = viewModel.crew, !crew.isEmpty {
            HeaderSection("Crew") {
                CrewThumbnails(crew: crew)
            }
        }
    }
}

#Preview {
    ShowCrew()
        .environmentObject(ShowViewModel(for: sampleMovie.toShow()))
}
