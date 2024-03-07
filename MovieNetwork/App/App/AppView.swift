//
//  AppView.swift
//  MovieNetwork
//
//  Created by Victorien Druon on 17/02/2024.
//

import SwiftUI

struct AppView: View {
    @StateObject var session = SessionManager()
    @StateObject var navigation = NavigationManager()

    var body: some View {
        TabView(selection: $navigation.activeTab) {
            ForEach(Tab.allCases) { tab in
                tab.view
                    .tag(tab)
                    .tabItem { Image(systemName: tab.icon) }
            }
        }
        .fullScreenCover(isPresented: $navigation.showingProfile) {
            ProfileView()
        }
        .onOpenURL(perform: navigation.routeUrl)
        .environmentObject(session)
        .environmentObject(navigation)
    }
}

#Preview {
    AppView()
}
