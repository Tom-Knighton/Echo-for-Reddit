//
//  Subreddit.swift
//  Models
//
//  Created by Tom Knighton on 06/02/2025.
//

import Foundation
import API

public struct Subreddit {
    /// The unique id, from Reddit, of this subreddit
    public let subredditId: String
    
    /// The name of this subreddit, i.e. 'all' for /r/all or 'gifs' for /r/GIFs
    public let subredditName: String
    
    /// The title of the subreddit, i.e. 'UK Politics' for /r/ukpolitics
    public let subredditTitle: String
    
    /// The url for the subreddit's icon
    public let subredditIconUrl: String?
    
    /// Whether or not the requesting user is banned from this subreddit
    public let userIsBanned: Bool
    
    /// The number of subscribers to this subreddit
    public let subredditSubscriberCount: Int
    
    /// Whether or not the subreddit is marked as NSFW
    public let subredditIsNSFW: Bool
    
    /// A brief public facing description of the subreddit
    public let subredditTagline: String
    
    /// The full description of the subreddit
    public let subredditDescription: String
    
    /// Whether or not the user is subscribed here
    public let userIsSubscribed: Bool
    
    /// The date in UTC the subreddit was created
    public let subredditCreatedUtc: Date?
    
    /// The image for a subreddit's wide banner
    public let bannerImageUrl: String?

    public init(
        subredditId: String,
        subredditName: String,
        subredditTitle: String,
        subredditIconUrl: String?,
        userIsBanned: Bool,
        subredditSubscriberCount: Int,
        subredditIsNSFW: Bool,
        subredditTagline: String,
        subredditDescription: String,
        userIsSubscribed: Bool,
        subredditCreatedUtc: Date,
        bannerImageUrl: String?
    ) {
        self.subredditId = subredditId
        self.subredditName = subredditName
        self.subredditTitle = subredditTitle
        self.subredditIconUrl = subredditIconUrl
        self.userIsBanned = userIsBanned
        self.subredditSubscriberCount = subredditSubscriberCount
        self.subredditIsNSFW = subredditIsNSFW
        self.subredditTagline = subredditTagline
        self.subredditDescription = subredditDescription
        self.userIsSubscribed = userIsSubscribed
        self.subredditCreatedUtc = subredditCreatedUtc
        self.bannerImageUrl = bannerImageUrl
    }
    
    public init(from subreddit: EchoAPI.GetSubredditQuery.Data.Reddit.Subreddit) {
        self.subredditId = subreddit.subredditId
        self.subredditName = subreddit.subredditName
        self.subredditTitle = subreddit.subredditTitle
        self.subredditIconUrl = subreddit.subredditIconUrl
        self.userIsBanned = subreddit.userIsBanned
        self.subredditSubscriberCount = subreddit.subredditSubscriberCount
        self.subredditIsNSFW = subreddit.subredditIsNSFW
        self.subredditTagline = subreddit.subredditTagline
        self.subredditDescription = subreddit.subredditDescription
        self.userIsSubscribed = subreddit.userIsSubscribed
        self.bannerImageUrl = subreddit.bannerImageUrl
        self.subredditCreatedUtc = nil
    }
}

extension Subreddit: Identifiable, Hashable, Equatable, Sendable {
    public var id: String { subredditId }
}
