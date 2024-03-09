//
//  Images.swift
//  MovieNetwork
//
//  Created by Victorien Druon on 05/03/2024.
//

import SwiftUI

struct RawImage: View {
    var url: URL?

    var body: some View {
        AsyncImage(url: url, transaction: Transaction(animation: .easeOut)) { phase in
            switch phase {
            case let .success(image):
                image
                    .resizable()
                    .scaledToFill()
            default: Color.neutral9
            }
        }
    }
}

struct RectImage: View {
    var url: URL?
    var aspectRatio: AspectRatio
    var width: CGFloat?
    var radius: CGFloat = 0

    var height: CGFloat? {
        if let width { return width * 1 / aspectRatio.value }
        else { return nil }
    }

    var body: some View {
        RawImage(url: url)
            .aspectRatio(aspectRatio.value, contentMode: .fit)
            .frame(width: width, height: height)
            .clipShape(RoundedRectangle(cornerRadius: radius))
    }
}

struct CircleImage: View {
    var url: URL?
    var size: CGFloat

    var body: some View {
        RawImage(url: url)
            .aspectRatio(contentMode: .fill)
            .frame(width: size, height: size)
            .clipShape(Circle())
    }
}
