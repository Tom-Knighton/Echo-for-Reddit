//
//  Post.swift
//  Models
//
//  Created by Tom Knighton on 06/02/2025.
//

import Foundation
import API
@preconcurrency import LinkPresentation

public final class Post: RedditThing, @unchecked Sendable {
    /// The unique Id, or name, of the post
    public let postId: String
    
    /// The base64-encoded cursor ID derived from the post ID
    public let cursorId: String
    
    /// The name of the author of the post
    public let postAuthor: String
    
    /// The flair of the author, if any
    public let postAuthorFlair: String?
    
    /// The name of the subreddit this post was posted to
    public let postSubreddit: String
    
    /// The title of the post
    public let postTitle: String
    
    /// The score to display for this post
    public let postScore: Int
    
    /// The ratio of up to downvotes, as a whole percentage
    public let postScorePercentage: Int?
    
    /// The number of comments on this post
    public let postCommentCount: Int
    
    /// The DateTime the post was created at
    public let postCreatedAt: Date
    
    /// If edited, the DateTime the post was last edited
    public let postEditedAt: Date?
    
    /// The icon of the subreddit this post was posted to
    public let subredditIcon: String?
    
    /// Flags on this post, including stickied status, nsfw, saved, etc.
    public let postFlagDetails: PostFlagDetails
    
    /// The actual content of this post, including text, images, videos, etc.
    public let postContent: PostContent
    
    /// How the user has voted, if at all, on this post
    public let postVoteStatus: VoteStatus?
    
    /// The post's flair, if any
    public let postFlair: String?
    
    /// How the post comments should be sorted by
    public let postRecommendedSort: RedditSortOption?
    
    public init(postId: String, cursorId: String, postAuthor: String, postAuthorFlair: String?, postSubreddit: String, postTitle: String, postScore: Int, postScorePercentage: Int, postCommentCount: Int, postCreatedAt: Date, postEditedAt: Date?, subredditIcon: String?, postFlagDetails: PostFlagDetails, postContent: PostContent, postVoteStatus: VoteStatus?, postFlair: String?, postRecommendedSort: RedditSortOption) {
        self.postId = postId
        self.cursorId = cursorId
        self.postAuthor = postAuthor
        self.postAuthorFlair = postAuthorFlair
        self.postSubreddit = postSubreddit
        self.postTitle = postTitle
        self.postScore = postScore
        self.postScorePercentage = postScorePercentage
        self.postCommentCount = postCommentCount
        self.postCreatedAt = postCreatedAt
        self.postEditedAt = postEditedAt
        self.subredditIcon = subredditIcon
        self.postFlagDetails = postFlagDetails
        self.postContent = postContent
        self.postVoteStatus = postVoteStatus
        self.postFlair = postFlair
        self.postRecommendedSort = postRecommendedSort
    }
    
    public init(from post: EchoAPI.GetSubredditPostsQuery.Data.Reddit.Subreddit.Posts.Edge.Node) {
        self.postId = post.postId
        self.cursorId = post.cursorId
        self.postAuthor = post.postAuthor
        self.postAuthorFlair = nil
        self.postSubreddit = post.postSubreddit
        self.postTitle = post.postTitle
        self.postScore = post.postScore
        self.postScorePercentage = nil
        self.postCommentCount = post.postCommentCount
        self.postCreatedAt = post.postCreatedAt
        self.postEditedAt = nil
        self.subredditIcon = post.subredditIcon
        self.postFlair = post.postFlair
        self.postRecommendedSort = nil
        self.postFlagDetails = .init(isNSFW: post.postFlagDetails.isNSFW, isSaved: post.postFlagDetails.isSaved, isLocked: post.postFlagDetails.isLocked, isStickied: post.postFlagDetails.isStickied, isArchived: post.postFlagDetails.isArchived, isSpoiler: post.postFlagDetails.isSpoiler)
        
        let contentType = PostContentType(rawValue: post.postContent.contentType.rawValue)
        let media = post.postContent.media.compactMap {
            PostMedia(url: $0.url, thumbnailUrl: $0.thumbnailUrl, height: $0.height, width: $0.width, hlsDashUrl: $0.hlsDashUrl, mediaText: nil, isInline: false, type: PostContentType(rawValue: $0.type?.rawValue ?? "image") ?? .image)
        }
        self.postContent = .init(textContent: post.postContent.textContent, contentType: contentType ?? .textOnly, media: media)
        self.postVoteStatus = VoteStatus(rawValue: post.postVoteStatus?.rawValue ?? VoteStatus.noVote.rawValue)
    }
}

extension Post: Identifiable, Equatable, Hashable {
    public static func == (lhs: Post, rhs: Post) -> Bool {
        lhs.postId == rhs.postId
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(postId)
    }
    
    
    public var id: String { postId }
}
