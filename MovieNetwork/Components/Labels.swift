//
//  Labels.swift
//  MovieNetwork
//
//  Created by Victorien Druon on 29/02/2024.
//

import SwiftUI

struct LabelLayout: LabelStyle {
    var alignment: LabelAlignment
    var spacing: LabelSpacing

    init(_ alignment: LabelAlignment = .left, _ spacing: LabelSpacing = .medium) {
        self.alignment = alignment
        self.spacing = spacing
    }

    func makeBody(configuration: Configuration) -> some View {
        switch alignment {
        case .left:
            HStack(spacing: spacing.value) {
                configuration.icon
                configuration.title
            }
        case .right:
            HStack(spacing: spacing.value) {
                configuration.title
                configuration.icon
            }
        case .top:
            VStack(spacing: spacing.value) {
                configuration.icon
                configuration.title
            }
        case .bottom:
            HStack(spacing: spacing.value) {
                configuration.title
                configuration.icon
            }
        }
    }
}

enum LabelAlignment {
    case left, right, top, bottom
}

enum LabelSpacing {
    case small, medium, large

    var value: CGFloat {
        switch self {
        case .small: 2
        case .medium: 4
        case .large: 6
        }
    }
}
