//
//  Texts.swift
//  MovieNetwork
//
//  Created by Victorien Druon on 21/02/2024.
//

import SwiftUI

struct LargeTitle: View {
    var content: String

    init(_ content: String) {
        self.content = content
    }

    var body: some View {
        Text(content)
            .font(.largeTitle)
            .fontWeight(.bold)
            .fontDesign(.rounded)
            .foregroundStyle(.neutral11)
    }
}

struct Title: View {
    var content: String

    init(_ content: String) {
        self.content = content
    }

    var body: some View {
        Text(content)
            .font(.title)
            .fontWeight(.bold)
            .fontDesign(.rounded)
            .foregroundStyle(.neutral11)
    }
}

struct Title2: View {
    var content: String

    init(_ content: String) {
        self.content = content
    }

    var body: some View {
        Text(content)
            .font(.title2)
            .fontWeight(.semibold)
            .fontDesign(.rounded)
            .foregroundStyle(.neutral11)
    }
}

struct Title3: View {
    var content: String

    init(_ content: String) {
        self.content = content
    }

    var body: some View {
        Text(content)
            .font(.title3)
            .fontWeight(.semibold)
            .fontDesign(.rounded)
            .foregroundStyle(.neutral11)
    }
}

struct Headline: View {
    var content: String

    init(_ content: String) {
        self.content = content
    }

    var body: some View {
        Text(content)
            .font(.headline)
            .fontWeight(.medium)
            .fontDesign(.rounded)
            .foregroundStyle(.neutral11)
    }
}

struct Callout: View {
    var content: String

    init(_ content: String) {
        self.content = content
    }

    var body: some View {
        Text(content)
            .font(.callout)
            .fontDesign(.rounded)
            .foregroundStyle(.neutral11)
    }
}

struct Footnote: View {
    var content: String

    init(_ content: String) {
        self.content = content
    }

    var body: some View {
        Text(content)
            .font(.footnote)
            .fontWeight(.light)
            .fontDesign(.rounded)
            .foregroundStyle(.neutral11)
    }
}

struct Caption: View {
    var content: String

    init(_ content: String) {
        self.content = content
    }

    var body: some View {
        Text(content)
            .font(.caption)
            .fontWeight(.thin)
            .fontDesign(.rounded)
            .foregroundStyle(.neutral11)
    }
}


struct BulletPoint: View {
    var body: some View {
        Headline("•")
            .foregroundStyle(.neutral4)
    }
}
