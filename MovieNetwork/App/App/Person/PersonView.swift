//
//  PersonView.swift
//  MovieNetwork
//
//  Created by Victorien Druon on 07/03/2024.
//

import SwiftUI

struct PersonView: View {
    @StateObject private var viewModel: PersonViewModel

    init(person: Person) {
        _viewModel = StateObject(wrappedValue: PersonViewModel(person: person))
    }
    
    var body: some View {
        Title3(viewModel.person.name)
    }
}

#Preview {
    let test = Person(
        id: 115440,
        name: "Sydney Sweeney",
        gender: .female,
        profilePath: URL(string: "/qYiaSl0Eb7G3VaxOg8PxExCFwon.jpg")!
    )
    
    return PersonView(person: test)
}
