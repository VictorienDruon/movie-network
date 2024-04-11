//
//  NavigationManager.swift
//  MovieNetwork
//
//  Created by Victorien Druon on 18/02/2024.
//

import Foundation
import SwiftUI

@MainActor
final class NavigationManager: ObservableObject {
    @Published var activeTab = Tab.discover {
        didSet {
            if activeTab == oldValue {
                withStack(of: activeTab) { stack in
                    stack.removeAll()
                }
            }
        }
    }

    @Published var discoverStack = Stack()
    @Published var watchlistStack = Stack()
    @Published var feedStack = Stack()
    @Published var profileStack = Stack()
    @Published var mediaSearchStack = Stack()
    @Published var userSearchStack = Stack()

    @Published var showingProfile = false
    @Published var showingMediaSearch = false
    @Published var showingUserSearch = false

    func withStack(of tab: Tab, task: (inout Stack) -> Void) {
        switch tab {
        case .discover: task(&discoverStack)
        case .watchlist: task(&watchlistStack)
        case .feed: task(&feedStack)
        }
    }

    func withActiveStack(task: (inout Stack) -> Void) {
        if showingProfile {
            task(&profileStack)
        } else if showingMediaSearch {
            task(&mediaSearchStack)
        } else if showingUserSearch {
            task(&userSearchStack)
        } else {
            withStack(of: activeTab, task: task)
        }
    }

    @ViewBuilder
    func routeTo(destination: Destination) -> some View {
        switch destination {
        case let .show(show):
            ShowView(for: show)
        case let .person(person):
            PersonView(for: person)
        case let .profile(user, currentUser):
            ProfileView(of: user, for: currentUser)
        }
    }

    func routeUrl(url: URL) {
        Task {
            let string = url.absoluteString.replacingOccurrences(of: appScheme, with: "")
            let paths = string.components(separatedBy: "/")

            guard
                let destination = paths.first,
                let parameter = paths.last
            else { return }

            switch destination {
            case "movie":
                guard let id = Int(parameter) else { return }
                let show = try await TMDbManager.shared.movie(for: id).toShow()
                withActiveStack { stack in
                    stack.append(.show(show))
                }
            case "tv":
                guard let id = Int(parameter) else { return }
                let show = try await TMDbManager.shared.tvSeries(for: id).toShow()
                withActiveStack { stack in
                    stack.append(.show(show))
                }
            case "person":
                guard let id = Int(parameter) else { return }
                let person = try await TMDbManager.shared.person(for: id)
                withActiveStack { stack in
                    stack.append(.person(person))
                }
            case "user":
                guard
                    let id = UUID(uuidString: parameter),
                    let currentUser = await RemoteDbManager.shared.currentSession()?.user.format(),
                    let user = try await RemoteDbManager.shared.getUser(id)
                else { return }
                withActiveStack { stack in
                    stack.append(.profile(user, currentUser))
                }
            default:
                return
            }
        }
    }
}
