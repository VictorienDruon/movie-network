//
//  TextFields.swift
//  MovieNetwork
//
//  Created by Victorien Druon on 21/02/2024.
//

import SwiftUI

struct StyledTextField: TextFieldStyle {
    @Environment(\.colorScheme) var colorScheme

    func _body(configuration: TextField<Self._Label>) -> some View {
        let isDark = colorScheme == .dark

        configuration
            .padding(.horizontal, 24)
            .frame(height: 48)
            .foregroundStyle(.neutral9)
            .background(
                LinearGradient(
                    colors: [
                        .neutral2.opacity(0.75),
                        .neutral2.opacity(1)
                    ],
                    startPoint: isDark ? .bottom : .top,
                    endPoint: isDark ? .top : .bottom
                ),
                in: Capsule()
            )
            .background(.background)
            .overlay(
                Capsule()
                    .stroke(.neutral4, lineWidth: 2)
                    .strokeBorder(.white.opacity(isDark ? 0 : 0.6), lineWidth: 2)
            )
    }
}

#Preview {
    TextField("Test", text: .constant(""))
        .textFieldStyle(StyledTextField())
        .padding()
}
