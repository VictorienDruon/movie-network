//
//  Buttons.swift
//  MovieNetwork
//
//  Created by Victorien Druon on 21/02/2024.
//

import SwiftUI

struct HeadlessButton: ButtonStyle {
    var size: ButtonSize
    var widthFull: Bool = false

    func makeBody(configuration: Configuration) -> some View {
        configuration
            .label
            .font(.system(size: size.config.fontSize, weight: .semibold, design: .rounded))
            .padding(.horizontal, size.config.paddingX)
            .frame(height: size.config.height)
            .frame(maxWidth: widthFull ? .infinity : nil)
    }
}

struct PrimaryButton: ButtonStyle {
    @Environment(\.colorScheme) var colorScheme

    var size: ButtonSize
    var widthFull: Bool

    init(_ size: ButtonSize, widthFull: Bool = false) {
        self.size = size
        self.widthFull = widthFull
    }

    func makeBody(configuration: Configuration) -> some View {
        let isDark = colorScheme == .dark
        let isPressed = configuration.isPressed

        HeadlessButton(size: size, widthFull: widthFull)
            .makeBody(configuration: configuration)
            .foregroundStyle(.white)
            .opacity(isPressed ? 0.5 : 1)
            .background(
                LinearGradient(
                    colors: [
                        .accent9.opacity(isPressed ? 1 : 0.75),
                        .accent9.opacity(isPressed ? 0.75 : 1)
                    ],
                    startPoint: isDark ? .bottom : .top,
                    endPoint: isDark ? .top : .bottom
                ),
                in: Capsule()
            )
            .background(.background)
            .overlay(
                Capsule()
                    .stroke(.accent10, lineWidth: 2)
                    .strokeBorder(.white.opacity(isDark ? 0 : 0.2), lineWidth: 2)
            )
    }
}

struct SecondaryButton: ButtonStyle {
    @Environment(\.colorScheme) var colorScheme

    var size: ButtonSize
    var widthFull: Bool

    init(_ size: ButtonSize, widthFull: Bool = false) {
        self.size = size
        self.widthFull = widthFull
    }

    func makeBody(configuration: Configuration) -> some View {
        let isDark = colorScheme == .dark
        let isPressed = configuration.isPressed

        HeadlessButton(size: size, widthFull: widthFull)
            .makeBody(configuration: configuration)
            .foregroundStyle(.white)
            .opacity(isPressed ? 0.5 : 1)
            .background(
                LinearGradient(
                    colors: [
                        .neutral9.opacity(isPressed ? 1 : 0.75),
                        .neutral9.opacity(isPressed ? 0.75 : 1)
                    ],
                    startPoint: isDark ? .bottom : .top,
                    endPoint: isDark ? .top : .bottom
                ),
                in: Capsule()
            )
            .background(.background)
            .overlay(
                Capsule()
                    .stroke(.neutral10, lineWidth: 2)
                    .strokeBorder(.white.opacity(isDark ? 0 : 0.2), lineWidth: 2)
            )
    }
}

struct SecondaryOutlineButton: ButtonStyle {
    @Environment(\.colorScheme) var colorScheme

    var size: ButtonSize
    var widthFull: Bool

    init(_ size: ButtonSize, widthFull: Bool = false) {
        self.size = size
        self.widthFull = widthFull
    }

    func makeBody(configuration: Configuration) -> some View {
        let isDark = colorScheme == .dark
        let isPressed = configuration.isPressed

        HeadlessButton(size: size, widthFull: widthFull)
            .makeBody(configuration: configuration)
            .foregroundStyle(.neutral9)
            .opacity(isPressed ? 0.5 : 1)
            .background(
                LinearGradient(
                    colors: [
                        .neutral2.opacity(isPressed ? 1 : 0.75),
                        .neutral2.opacity(isPressed ? 0.75 : 1)
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

enum ButtonSize {
    case small, medium, large

    var config: ButtonSizeConfig {
        switch self {
        case .small:
            ButtonSizeConfig(height: 32, paddingX: 16, fontSize: 14)
        case .medium:
            ButtonSizeConfig(height: 40, paddingX: 20, fontSize: 18)
        case .large:
            ButtonSizeConfig(height: 48, paddingX: 24, fontSize: 22)
        }
    }
}

struct ButtonSizeConfig {
    var height: CGFloat
    var paddingX: CGFloat
    var fontSize: CGFloat
}

#Preview {
    VStack {
        Button("Hello") {}
            .buttonStyle(PrimaryButton(.large))

        Button("Hello") {}
            .buttonStyle(SecondaryButton(.large))

        Button("Hello") {}
            .buttonStyle(SecondaryOutlineButton(.large))
    }
    .padding()
}
