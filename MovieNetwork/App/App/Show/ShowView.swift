//
//  ShowView.swift
//  MovieNetwork
//
//  Created by Victorien Druon on 07/03/2024.
//

import SwiftUI

struct ShowView: View {
    @StateObject private var viewModel: ShowViewModel

    init(show: Show) {
        _viewModel = StateObject(wrappedValue: ShowViewModel(show: show))
    }

    var body: some View {
        Title3(viewModel.show.title)
    }
}

#Preview {
    let test = Show.movie(
        Movie(
            id: 792307,
            title: "Poor Things",
            posterPath: URL(string: "/kCGlIMHnOm8JPXq3rXM6c5wMxcT.jpg")
        )
    )

    return ShowView(show: test)
}
