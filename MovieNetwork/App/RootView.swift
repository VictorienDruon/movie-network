//
//  RootView.swift
//  MovieNetwork
//
//  Created by Victorien Druon on 17/02/2024.
//

import SwiftUI

struct RootView: View {
    @AppStorage("isOnBoarded") var isOnBoarded: Bool = false

    init() {
        configureNavigationAppearance()
    }

    var body: some View {
        if isOnBoarded {
            AppView()
        } else {
            OnBoardingView()
        }
    }
}

#Preview {
    RootView()
}
