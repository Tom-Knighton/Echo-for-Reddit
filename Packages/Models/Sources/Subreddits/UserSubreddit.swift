//
//  UserSubreddit.swift
//  Models
//
//  Created by Tom Knighton on 06/02/2025.
//
import Foundation
import API

public struct UserSubreddit {
    
    public let subredditTitle: String
    public let bannerImageUrl: String?
    public let subredditIsNSFW: Bool
    
    public init(from meQuerySubreddit: EchoAPI.GetCurrentUserQuery.Data.Reddit.Me.UserSubreddit) {
        self.subredditTitle = meQuerySubreddit.subredditTitle
        self.bannerImageUrl = meQuerySubreddit.bannerImageUrl
        self.subredditIsNSFW = meQuerySubreddit.subredditIsNSFW
    }
}

extension UserSubreddit: Identifiable, Hashable, Equatable {
    public var id: String {
        subredditTitle
    }
}
