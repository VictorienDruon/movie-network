//
//  PersonToolbar.swift
//  MovieNetwork
//
//  Created by Victorien Druon on 09/03/2024.
//

import Foundation
import SwiftUI

struct PersonToolbar: ToolbarContent {
    @EnvironmentObject var viewModel: PersonViewModel

    var body: some ToolbarContent {
        ToolbarItem {
            Menu("More", systemImage: "ellipsis.circle") {
                ShareLink(item: viewModel.person.link)
            }
        }
    }
}

#Preview {
    NavigationStack {
        ScrollView {}
            .navigationTitle("Test")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar { PersonToolbar() }
            .environmentObject(PersonViewModel(for: samplePerson))
    }
}
