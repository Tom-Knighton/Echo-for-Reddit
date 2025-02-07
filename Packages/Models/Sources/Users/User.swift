//
//  User.swift
//  Models
//
//  Created by Tom Knighton on 06/02/2025.
//
import Foundation
import API

public struct User {
    /// The t2_ id of the user
    public let id: String
    
    /// The url of the user's profile icon
    public let iconImageUrl: String
    
    /// The friendly name of the user
    public let name: String
    
    /// The public bio of the user
    public let description: String?
    
    /// The user's total karma points
    public let totalKarma: Int
    
    /// The user's post Karma points
    public let postKarma: Int
    
    /// The user's comment karma points
    public let commentKarma: Int
    
    /// The UTC date the user was created at
    public let createdAt: Date
    
    /// The name of the user's subreddit
    public let userSubredditId: String?
    
    public init(id: String, iconImageUrl: String, name: String, description: String?, totalKarma: Int, postKarma: Int, commentKarma: Int, createdAt: Date, userSubredditId: String) {
        self.id = id
        self.iconImageUrl = iconImageUrl
        self.name = name
        self.description = description
        self.totalKarma = totalKarma
        self.postKarma = postKarma
        self.commentKarma = commentKarma
        self.createdAt = createdAt
        self.userSubredditId = userSubredditId
    }
    
    public init(from meQuery: EchoAPI.GetCurrentUserQuery.Data.Reddit.Me) {
        self.id = meQuery.id
        self.iconImageUrl = meQuery.iconImageUrl
        self.name = meQuery.name
        self.description = meQuery.description
        self.totalKarma = meQuery.totalKarma
        self.postKarma = meQuery.postKarma
        self.commentKarma = meQuery.commentKarma
        self.createdAt = meQuery.createdAt
        self.userSubredditId = nil
    }
}

extension User: Equatable, Identifiable, Hashable, Sendable {
}
