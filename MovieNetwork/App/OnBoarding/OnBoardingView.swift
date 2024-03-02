//
//  OnBoardingView.swift
//  MovieNetwork
//
//  Created by Victorien Druon on 17/02/2024.
//

import SwiftUI

struct OnBoardingView: View {
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()

                VStack {
                    LargeTitle("Movie Network")
                    Title2("A place for movie lovers")
                }

                Spacer()

                VStack(spacing: 16) {
                    AppleSignInButton()
                    Button("Not now") { markUserAsOnboarded() }
                        .buttonStyle(StyledButton(.secondaryOutline, .large, widthFull: true))
                }
            }
            .padding()
        }
    }
}

#Preview {
    OnBoardingView()
}
