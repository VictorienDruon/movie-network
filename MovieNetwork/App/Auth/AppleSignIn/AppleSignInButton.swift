//
//  AppleSignInButton.swift
//  MovieNetwork
//
//  Created by Victorien Druon on 26/02/2024.
//

import _AuthenticationServices_SwiftUI
import SwiftUI

struct AppleSignInButton: View {
    @Environment(\.colorScheme) var currentScheme
    @StateObject var viewModel = AppleSignInViewModel()

    var body: some View {
        if currentScheme == .light {
            buildButton()
                .signInWithAppleButtonStyle(.black)
        } else {
            buildButton()
                .signInWithAppleButtonStyle(.white)
        }
    }

    private func buildButton() -> some View {
        SignInWithAppleButton(
            onRequest: viewModel.setScopes,
            onCompletion: viewModel.signIn
        )
        .frame(height: 48)
        .clipShape(Capsule())
        .errorAlert($viewModel.errorInfo)
    }
}

#Preview {
    AppleSignInButton()
        .padding()
}
