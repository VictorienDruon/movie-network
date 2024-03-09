//
//  TextBlock.swift
//  MovieNetwork
//
//  Created by Victorien Druon on 09/03/2024.
//

import SwiftUI

struct TextBlock: View {
    @State var showingSheet = false

    var title: String
    var content: String

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 8) {
                Headline(title)
                BodyText(content)
                    .lineLimit(4)
            }

            Spacer()
        }
        .padding(.horizontal, 24)
        .padding(.vertical, 20)
        .background(.neutral2)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .onTapGesture { showingSheet = true }
        .sheet(isPresented: $showingSheet) {
            VStack(alignment: .leading, spacing: 0) {
                VStack(spacing: 0) {
                    Headline(title)
                        .padding()
                    Divider()
                        .foregroundStyle(.neutral4)
                }

                ScrollView {
                    BodyText(content)
                        .padding()
                }
            }
        }
    }
}

#Preview {
    TextBlock(title: "Hello there", content: "I was hoping for Kenobi")
        .padding(.horizontal)
}
