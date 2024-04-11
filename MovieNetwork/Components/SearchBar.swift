//
//  SearchBar.swift
//  MovieNetwork
//
//  Created by Victorien Druon on 11/04/2024.
//

import SwiftUI

struct SearchBar: View {
    @FocusState private var isSearchbarFocused: Bool
    @StateObject var textObserver = TextFieldObserver()

    var placeholder: String
    var onChange: (String) -> Void

    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundStyle(.tertiary)
            TextField(placeholder, text: $textObserver.query)
                .foregroundStyle(.neutral11)
                .keyboardType(.asciiCapable)
                .autocorrectionDisabled()
                .focused($isSearchbarFocused)
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        isSearchbarFocused = true
                    }
                }
                .onChange(of: textObserver.debouncedQuery) {
                    onChange(textObserver.debouncedQuery)
                }
        }
        .font(.system(size: 22, weight: .medium, design: .rounded))
        .padding(.horizontal, 16)
        .frame(height: 55)
        .background(.regularMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 14))
        .shadowSize(.large)
        .padding()
    }
}

class TextFieldObserver: ObservableObject {
    @Published var query = ""
    @Published var debouncedQuery = ""

    init() {
        $query
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .assign(to: &$debouncedQuery)
    }
}

#Preview {
    SearchBar(placeholder: "Placeholder") { query in
        print(query)
    }
}
