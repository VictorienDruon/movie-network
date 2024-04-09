//
//  Avatar.swift
//  MovieNetwork
//
//  Created by Victorien Druon on 09/04/2024.
//

import SwiftUI

struct Avatar: View {
    var id: UUID
    var url: URL?
    var size: ThumbnailSize

    var body: some View {
        if let url {
            Thumbnail(url: url, size: size)
        } else {
            let gradient = getGradientColorsFromId(id)

            Circle()
                .frame(width: size.config.width, height: size.config.width)
                .foregroundStyle(
                    LinearGradient(
                        colors: [gradient.from, gradient.to],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .shadowSize(size.config.shadowSize)
        }
    }
}

#Preview {
    Avatar(id: UUID(), url: nil, size: .large)
}
