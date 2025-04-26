//
//  RouterDestination.swift
//  Env
//
//  Created by Tom Knighton on 02/02/2025.
//

import Models

public enum RouterDestination: Hashable {
    case profile(username: String)
    case subreddits
    case subreddit(subredditName: String)
    case postId(_ postId: String)
    case post(_ post: Post)
}
