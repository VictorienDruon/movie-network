//
//  Alerts.swift
//  MovieNetwork
//
//  Created by Victorien Druon on 27/02/2024.
//

import SwiftUI

extension View {
    func errorAlert(_ error: Binding<ErrorInfo?>) -> some View {
        alert(
            isPresented: .constant(error.wrappedValue != nil),
            error: error.wrappedValue,
            actions: { _ in Button("OK") { error.wrappedValue = nil }},
            message: { error in Text(error.recoverySuggestion ?? "") }
        )
    }
}

struct ErrorInfo: LocalizedError {
    public var errorDescription: String?
    var failureReason: String?
    var recoverySuggestion: String?
    var helpAnchor: String?
}
