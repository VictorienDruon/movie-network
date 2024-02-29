//
//  AuthRequiredView.swift
//  MovieNetwork
//
//  Created by Victorien Druon on 23/02/2024.
//

import SwiftUI

struct AuthRequiredView: View {
    var message: String

    var body: some View {
        VStack(spacing: 32) {
            Title3(message)
                .multilineTextAlignment(.center)

            AppleSignInButton()
        }
        .padding()
    }
}

#Preview {
    NavigationStack {
        AuthRequiredView(message: "You need to sign up.")
    }
}
