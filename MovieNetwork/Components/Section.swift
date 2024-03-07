//
//  Section.swift
//  MovieNetwork
//
//  Created by Victorien Druon on 07/03/2024.
//

import SwiftUI

struct Section<Content: View>: View {
    var title: String
    @ViewBuilder var content: Content

    init(_ title: String, @ViewBuilder content: () -> Content) {
        self.title = title
        self.content = content()
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Title3(title)
                .padding(.horizontal, 16)

            content
        }
    }
}
