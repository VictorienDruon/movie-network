//
//  AppleSignInViewModel.swift
//  MovieNetwork
//
//  Created by Victorien Druon on 26/02/2024.
//

import Auth
import AuthenticationServices
import Foundation

@MainActor
final class AppleSignInViewModel: ObservableObject {
    @Published var errorInfo: ErrorInfo?

    func setScopes(_ request: ASAuthorizationAppleIDRequest) {
        request.requestedScopes = [.email, .fullName]
    }

    func signIn(_ result: Result<ASAuthorization, Error>) {
        Task {
            do {
                guard
                    let credential = try? result.get().credential as? ASAuthorizationAppleIDCredential,
                    let idToken = credential.identityToken.flatMap({ String(data: $0, encoding: .utf8) })
                else { return }

                try await signInWithApple(idToken: idToken)

                try await updateUserName(fullName: credential.fullName)

                markUserAsOnboarded()
            } catch AppleSignInError.signInWithAppleFailed {
                errorInfo = ErrorInfo(
                    errorDescription: "Sign in failed",
                    recoverySuggestion: "Check your internet connection and try again."
                )
            } catch AppleSignInError.userUpdateFailed {
                errorInfo = ErrorInfo(
                    errorDescription: "Failed to update user informations",
                    recoverySuggestion: "Check your internet connection and try again."
                )
            } catch {
                errorInfo = ErrorInfo(
                    errorDescription: "An unexpected error occurred",
                    recoverySuggestion: "Please try again later."
                )
            }
        }
    }

    private func signInWithApple(idToken: String) async throws {
        do {
            try await AuthManager.shared.signInWithIdToken(for: .apple, with: idToken)
        } catch {
            throw AppleSignInError.signInWithAppleFailed
        }
    }

    private func updateUserName(fullName: PersonNameComponents?) async throws {
        let firstName = fullName?.givenName ?? ""
        let lastName = fullName?.familyName ?? ""

        if firstName.isEmpty && lastName.isEmpty { return }

        let separator = firstName.isEmpty || lastName.isEmpty ? "" : " "
        let fullName = [firstName, lastName].joined(separator: separator)
        let userAttributes = UserAttributes(data: ["full_name": .string(fullName)])

        do {
            try await AuthManager.shared.updateUser(from: userAttributes)
        } catch {
            throw AppleSignInError.userUpdateFailed
        }
    }

    enum AppleSignInError: Error {
        case signInWithAppleFailed
        case userUpdateFailed
        case unknown
    }
}
