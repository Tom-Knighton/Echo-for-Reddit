//
//  WithRouting.swift
//  Echo
//
//  Created by Tom Knighton on 04/02/2025.
//

import SwiftUI
import Env
import User
import Subreddits

extension View {
    
    public func withEchoRoutes() -> some View {
        navigationDestination(for: RouterDestination.self) { destination in
            switch destination {
            case let .profile(username):
                UserPageView()
            case let .subreddit(subredditName):
                SubredditPage(subredditName: subredditName)
            case .subreddits:
                SubredditListPage()
            }
        }
    }
}
