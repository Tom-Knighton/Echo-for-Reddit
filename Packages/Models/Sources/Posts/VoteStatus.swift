//
//  VoteStatus.swift
//  Models
//
//  Created by Tom Knighton on 06/02/2025.
//

public enum VoteStatus: String {
    case upvoted = "UPVOTED"
    case downvoted = "DOWNVOTED"
    case noVote = "NO_VOTE"
}

extension VoteStatus: Sendable {}
