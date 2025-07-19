//
//  PostContentView.swift
//  Posts
//
//  Created by Tom Knighton on 19/04/2025.
//

import SwiftUI
import Models
import RedditMarkdownView

public struct PostContentView: View {
    
    private let post: Post
    public init(post: Post) {
        self.post = post
    }
    
    
//    private var config: SnudownConfig = Snudow
    
    public var body: some View {
        VStack() {
            Text(post.postTitle)
                .font(.title3.bold())
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Divider()
            
            switch post.postContent.contentType {
                
            case .textOnly:
                SnudownView(text: post.postContent.textContent ?? "")
                    .snudownFont(for: .h1, .title2)
                    .snudownFont(for: .h2, .title3)
                    .snudownFont(for: .h3, .title3)
                    .snudownFont(for: .h4, .headline)
                    .snudownFont(for: .h5, .callout)
                    .snudownFont(for: .h6, .body)
                    .snudownDisplayInlineImages(false)
                    .snudownTextAlignment(.leading)
                    .snudownMultilineAlignment(.leading)
            default:
                EmptyView()
            }
        }
        .fontDesign(.rounded)
        .frame(maxWidth: .infinity)
        .padding(.horizontal, 12)
    }
}

#Preview {
    PostContentView(post: Post(postId: "1", cursorId: "1", postAuthor: "SomeRedditUser", postAuthorFlair: nil, postSubreddit: "UKPolitics", postTitle: "Wow! TIL You could make a Reddit app smelly smelly smelly smelly...", postScore: 100, postScorePercentage: 100, postCommentCount: 100, postCreatedAt: Date(), postEditedAt: nil, subredditIcon: nil, postFlagDetails: .init(isNSFW: false, isSaved: false, isLocked: false, isStickied: false, isArchived: false, isSpoiler: false), postContent: .init(textContent: "Some content...", contentType: .textOnly, media: []), postVoteStatus: .noVote, postFlair: "Some flair", postRecommendedSort: .best, parentPost: Post(postId: "1", cursorId: "1", postAuthor: "SomeRedditUser", postAuthorFlair: nil, postSubreddit: "UKPolitics", postTitle: "Wow! TIL You could make a Reddit app smelly smelly smelly smelly...", postScore: 100, postScorePercentage: 100, postCommentCount: 100, postCreatedAt: Date(), postEditedAt: nil, subredditIcon: nil, postFlagDetails: .init(isNSFW: false, isSaved: false, isLocked: false, isStickied: false, isArchived: false, isSpoiler: false), postContent: .init(textContent: "Some content...", contentType: .textOnly, media: []), postVoteStatus: .noVote, postFlair: "Some flair", postRecommendedSort: .best)))
}
