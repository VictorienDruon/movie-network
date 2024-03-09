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
        .padding(.horizontal)
        .onTapGesture { showingSheet = true }
        .sheet(isPresented: $showingSheet) {
            NavigationStack {
                BodyText(content)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                    .padding()
                    .navigationTitle(title)
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar {
                        ToolbarItem(placement: .confirmationAction) {
                            Button("OK") {
                                showingSheet = false
                            }
                        }
                    }
            }
        }
    }
}

#Preview {
    TextBlock(title: "Hello there", content: "I was hoping for Kenobi")
}
