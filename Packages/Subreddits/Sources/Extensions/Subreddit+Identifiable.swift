//
//  Subreddit+Identifiable.swift
//  Subreddits
//
//  Created by Tom Knighton on 03/02/2025.
//

import API

extension EchoAPI.SubscribedSubredditFragment: @retroactive Identifiable {
    public var id: String {
        self.subredditId
    }
}
