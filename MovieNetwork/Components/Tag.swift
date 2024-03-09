//
//  Tag.swift
//  MovieNetwork
//
//  Created by Victorien Druon on 09/03/2024.
//

import SwiftUI

struct Tag: View {
    var name: String
    var size: ButtonSize

    init(_ name: String, size: ButtonSize = .medium) {
        self.name = name
        self.size = size
    }

    var body: some View {
        Text(name)
            .font(.system(size: size.config.fontSize, weight: .semibold, design: .rounded))
            .foregroundStyle(.neutral9)
            .padding(.horizontal, size.config.paddingX)
            .frame(height: size.config.height)
            .frame(maxWidth: size == .full ? .infinity : nil)
            .background(.neutral2)
            .clipShape(Capsule())
    }
}

#Preview {
    Tag("Hello", size: .large)
}
