//
//  PostFlagDetails.swift
//  Models
//
//  Created by Tom Knighton on 06/02/2025.
//

public struct PostFlagDetails {
    
    /// If the content is marked as NSFW or 'Over 18'
    public let isNSFW: Bool
    
    /// Whether or not the current user has saved this content
    public let isSaved: Bool
    
    /// Whether or not the content is locked, and no more changes are allowed
    public let isLocked: Bool
    
    /// Whether or not the content is stickied to the top of the parent
    public let isStickied: Bool
    
    /// Whether or not the content is archived and no more changes can be made
    public let isArchived: Bool
    
    /// Whether or not the content is marked as a 'spoiler' and should be 'hidden' or blurred
    public let isSpoiler: Bool
    
    /// The distinguishment type of the content, i.e. whether it has been distinguished as from a moderator, admin or special admin
    public let distinguishmentType: DistinguishmentType = .none
    
    public init(isNSFW: Bool, isSaved: Bool, isLocked: Bool, isStickied: Bool, isArchived: Bool, isSpoiler: Bool) {
        self.isNSFW = isNSFW
        self.isSaved = isSaved
        self.isLocked = isLocked
        self.isStickied = isStickied
        self.isArchived = isArchived
        self.isSpoiler = isSpoiler
    }
}

extension PostFlagDetails: Equatable, Sendable {
    
}
