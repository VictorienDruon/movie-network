//
//  Shadows.swift
//  MovieNetwork
//
//  Created by Victorien Druon on 05/03/2024.
//

import SwiftUI

struct Shadow: ViewModifier {
    var size: ShadowSize

    func body(content: Content) -> some View {
        content
            .shadow(radius: size.config.radius, y: size.config.y)
    }
}

extension View {
    func shadowSize(_ size: ShadowSize) -> some View {
        modifier(Shadow(size: size))
    }
}

enum ShadowSize {
    case extraSmall, small, medium, large

    var config: ShadowConfig {
        switch self {
        case .extraSmall:
            ShadowConfig(radius: 4, y: 2)
        case .small:
            ShadowConfig(radius: 6, y: 4)
        case .medium:
            ShadowConfig(radius: 8, y: 6)
        case .large:
            ShadowConfig(radius: 10, y: 8)
        }
    }
}

struct ShadowConfig {
    var radius: CGFloat
    var y: CGFloat
}
