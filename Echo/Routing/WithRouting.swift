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
import Posts

extension View {
    
    
    public func withEchoRoutes(postNavNamespace: Namespace.ID) -> some View {
        navigationDestination(for: RouterDestination.self) { destination in
            switch destination {
            case let .profile(username):
                UserPageView()
            case let .subreddit(subredditName):
                SubredditPage(subredditName: subredditName)
            case .subreddits:
                SubredditListPage()
            case let .postId(id):
                PostView(postId: id)
            case let .post(post):
                PostView(with: post)
//                    .navigationTransition(
//                        .zoom(sourceID: post.id, in: postNavNamespace)
//                    )
            }
        }
    }
}
