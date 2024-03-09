//
//  PersonView.swift
//  MovieNetwork
//
//  Created by Victorien Druon on 07/03/2024.
//

import SwiftUI

struct PersonView: View {
    @StateObject private var viewModel: PersonViewModel

    init(for person: Person) {
        _viewModel = StateObject(wrappedValue: PersonViewModel(for: person))
    }
    
    var body: some View {
        Title3(viewModel.person.name)
    }
}

#Preview {
    PersonView(for: samplePerson)
}
