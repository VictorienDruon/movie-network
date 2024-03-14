//
//  Buttons.swift
//  MovieNetwork
//
//  Created by Victorien Druon on 21/02/2024.
//

import SwiftUI

struct HeadlessButton: ButtonStyle {
    var size: ButtonSize

    func makeBody(configuration: Configuration) -> some View {
        configuration
            .label
            .font(.system(size: size.config.fontSize, weight: .semibold, design: .rounded))
            .padding(.horizontal, size.config.paddingX)
            .frame(height: size.config.height)
            .frame(maxWidth: size == .full ? .infinity : nil)
    }
}

struct StyledButton: ButtonStyle {
    @Environment(\.colorScheme) var colorScheme

    var variant: ButtonVariant
    var size: ButtonSize
    var iconOnly: Bool

    init(_ variant: ButtonVariant, _ size: ButtonSize, iconOnly: Bool = false) {
        self.variant = variant
        self.size = size
        self.iconOnly = iconOnly
    }

    func makeBody(configuration: Configuration) -> some View {
        let isDark = colorScheme == .dark
        let isPressed = configuration.isPressed

        HeadlessButton(size: size)
            .makeBody(configuration: configuration)
            .foregroundStyle(variant.config.textColor)
            .opacity(isPressed ? 0.5 : 1)
            .background(
                LinearGradient(
                    colors: [
                        variant.config.bgColor.opacity(isPressed ? 1 : 0.75),
                        variant.config.bgColor.opacity(isPressed ? 0.75 : 1)
                    ],
                    startPoint: isDark ? .bottom : .top,
                    endPoint: isDark ? .top : .bottom
                )
            )
            .background(.background)
            .clipShape(iconOnly ? AnyShape(.circle) : AnyShape(.capsule))
            .overlay {
                if iconOnly {
                    Circle()
                        .stroke(variant.config.strokeColor, lineWidth: 2)
                        .strokeBorder(.white.opacity(isDark ? 0 : variant.config.strokeOpacity), lineWidth: 2)
                } else {
                    Capsule()
                        .stroke(variant.config.strokeColor, lineWidth: 2)
                        .strokeBorder(.white.opacity(isDark ? 0 : variant.config.strokeOpacity), lineWidth: 2)
                }
            }
    }
}

struct TransparentButton: ButtonStyle {
    var size: ButtonSize
    var iconOnly: Bool
    var widthFull: Bool

    init(_ size: ButtonSize, iconOnly: Bool = false, widthFull: Bool = false) {
        self.size = size
        self.iconOnly = iconOnly
        self.widthFull = widthFull
    }

    func makeBody(configuration: Configuration) -> some View {
        let isPressed = configuration.isPressed

        HeadlessButton(size: size)
            .makeBody(configuration: configuration)
            .foregroundStyle(.white)
            .opacity(isPressed ? 0.5 : 1)
            .background(.ultraThinMaterial)
            .clipShape(iconOnly ? AnyShape(.circle) : AnyShape(.capsule))
            .shadowSize(.small)
    }
}

struct Pressable: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        let isPressed = configuration.isPressed

        configuration
            .label
            .scaleEffect(isPressed ? 0.975 : 1)
            .animation(.easeOut(duration: 0.1), value: configuration.isPressed)
    }
}

enum ButtonVariant {
    case primary, secondary, secondaryOutline

    var config: ButtonVariantConfig {
        switch self {
        case .primary:
            ButtonVariantConfig(bgColor: .accent9, strokeColor: .accent10, strokeOpacity: 0.2, textColor: .white)
        case .secondary:
            ButtonVariantConfig(bgColor: .neutral9, strokeColor: .neutral10, strokeOpacity: 0.2, textColor: .white)
        case .secondaryOutline:
            ButtonVariantConfig(bgColor: .neutral2, strokeColor: .neutral4, strokeOpacity: 0.6, textColor: .neutral9)
        }
    }
}

struct ButtonVariantConfig {
    var bgColor: Color
    var strokeColor: Color
    var strokeOpacity: CGFloat
    var textColor: Color
}

enum ButtonSize {
    case small, medium, large, full

    var config: ButtonSizeConfig {
        switch self {
        case .small:
            ButtonSizeConfig(height: 32, paddingX: 10, fontSize: 14)
        case .medium:
            ButtonSizeConfig(height: 40, paddingX: 12, fontSize: 18)
        case .large:
            ButtonSizeConfig(height: 48, paddingX: 14, fontSize: 22)
        case .full:
            ButtonSize.large.config
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
            .buttonStyle(StyledButton(.primary, .small))

        Button("Hello") {}
            .buttonStyle(StyledButton(.secondary, .medium))

        Button("Hello") {}
            .buttonStyle(StyledButton(.secondaryOutline, .large))

        Button("Hello") {}
            .buttonStyle(TransparentButton(.large))
    }
    .padding()
}
