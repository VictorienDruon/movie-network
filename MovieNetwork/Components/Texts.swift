//
//  Texts.swift
//  MovieNetwork
//
//  Created by Victorien Druon on 21/02/2024.
//

import SwiftUI

struct BodyText: View {
    var content: String

    init(_ content: String) {
        self.content = content
    }

    var body: some View {
        Text(content)
            .fontDesign(.rounded)
            .foregroundStyle(.neutral11)
    }
}

struct LargeTitle: View {
    var content: String

    init(_ content: String) {
        self.content = content
    }

    var body: some View {
        BodyText(content)
            .font(.largeTitle)
            .fontWeight(.bold)
    }
}

struct Title: View {
    var content: String

    init(_ content: String) {
        self.content = content
    }

    var body: some View {
        BodyText(content)
            .font(.title)
            .fontWeight(.bold)
    }
}

struct Title2: View {
    var content: String

    init(_ content: String) {
        self.content = content
    }

    var body: some View {
        BodyText(content)
            .font(.title2)
            .fontWeight(.semibold)
    }
}

struct Title3: View {
    var content: String

    init(_ content: String) {
        self.content = content
    }

    var body: some View {
        BodyText(content)
            .font(.title3)
            .fontWeight(.semibold)
    }
}

struct Headline: View {
    var content: String

    init(_ content: String) {
        self.content = content
    }

    var body: some View {
        BodyText(content)
            .font(.headline)
            .fontWeight(.medium)
    }
}

struct Callout: View {
    var content: String

    init(_ content: String) {
        self.content = content
    }

    var body: some View {
        BodyText(content)
            .font(.callout)
    }
}

struct Footnote: View {
    var content: String

    init(_ content: String) {
        self.content = content
    }

    var body: some View {
        BodyText(content)
            .font(.footnote)
            .fontWeight(.light)
    }
}

struct Caption: View {
    var content: String

    init(_ content: String) {
        self.content = content
    }

    var body: some View {
        BodyText(content)
            .font(.caption)
            .fontWeight(.thin)
    }
}
