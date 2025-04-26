//
//  ListPostView.swift
//  Posts
//
//  Created by Tom Knighton on 04/02/2025.
//

import Design
import SwiftUI
import ComposableArchitecture
import Models
import Env
@preconcurrency import LinkPresentation

public struct ListPostView: View {
    
    @Environment(\.theme) private var theme
    @Environment(\.linkManager) private var linkManager
    @Environment(\.openURL) private var openURL
    let store: StoreOf<PostListFeature>
    @State private var metadata: LPLinkMetadata? = nil
    private var isCrossPost: Bool = false
    
    public init() {
        store = StoreOf<PostListFeature>(initialState: PostListFeature.State()) { PostListFeature() }
    }
    
    public init(with post: Post, isCrossPost: Bool = false) {
        store = StoreOf<PostListFeature>(initialState: PostListFeature.State(post: post)) { PostListFeature() }
        store.send(.loadPost(post))
        self.isCrossPost = isCrossPost
    }
    
    public var body: some View {
        VStack(spacing: 0) {
            ZStack {
                if store.isLoading {
                    ProgressView()
                }
                
                if let post = store.post {
                    NavigationLink(value: RouterDestination.post(post)) {
                        postView(for: post)
                    }
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(isCrossPost ? theme.layer2 : theme.primaryBackground)
            .fontDesign(.rounded)
            .clipShape(.rect(cornerRadius: isCrossPost ? 10 : 0))
            
            if !isCrossPost {
                Rectangle()
                    .fill(theme.layer2)
                    .frame(height: 12)
            }
        }
    }
    
    @ViewBuilder
    private func postView(for post: Post) -> some View {
        VStack {
            Text(post.postTitle)
                .font(.headline)
                .frame(maxWidth: .infinity, alignment: .leading)
                .fixedSize(horizontal: false, vertical: true)
            
            if post.postContent.contentType == .textOnly, let textContent = post.postContent.textContent, !textContent.isEmpty {
                PostTextContent(textContent: textContent)
            }
            
            if let parent = post.parentPost {
                ListPostView(with: parent, isCrossPost: true)
            }
            
            if post.postContent.contentType == .linkOnly {
                if let subreddit = post.postContent.media.first?.url.extractSubreddit() {
                    SubredditLink(subredditName: subreddit)
                } else if let linkData = store.data {
                    OGLinkView(data: linkData)
                } else if store.dataFailed {
                    GenericLinkView(post.postContent.media.first?.url ?? "")
                } else {
                    Rectangle()
                        .fill(theme.layer3)
                        .frame(height: 250)
                        .clipShape(.rect(cornerRadius: 10))
                        .redacted(reason: .placeholder)
                        .onTapGesture {
                            if store.data == nil, post.postContent.contentType == .linkOnly, let url = URL(string: post.postContent.media.first?.url ?? "") {
                                self.openURL(url)
                            }
                        }
                }
            }
           
            PostDetailsView(post, isCrossPost: isCrossPost)

        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 12)
        .padding(.vertical, 12)
        .multilineTextAlignment(.leading)
    }
}

#Preview {
    @Previewable @Environment(\.colorScheme) var colorScheme
    let post = Post(postId: "1", cursorId: "1", postAuthor: "SomeRedditUser", postAuthorFlair: nil, postSubreddit: "UKPolitics", postTitle: "Wow! TIL You could make a Reddit app smelly smelly smelly smelly...", postScore: 100, postScorePercentage: 100, postCommentCount: 100, postCreatedAt: Date(), postEditedAt: nil, subredditIcon: nil, postFlagDetails: .init(isNSFW: false, isSaved: false, isLocked: false, isStickied: false, isArchived: false, isSpoiler: false), postContent: .init(textContent: "Some content...", contentType: .textOnly, media: []), postVoteStatus: .noVote, postFlair: "Some flair", postRecommendedSort: .best, parentPost: Post(postId: "1", cursorId: "1", postAuthor: "SomeRedditUser", postAuthorFlair: nil, postSubreddit: "UKPolitics", postTitle: "Wow! TIL You could make a Reddit app smelly smelly smelly smelly...", postScore: 100, postScorePercentage: 100, postCommentCount: 100, postCreatedAt: Date(), postEditedAt: nil, subredditIcon: nil, postFlagDetails: .init(isNSFW: false, isSaved: false, isLocked: false, isStickied: false, isArchived: false, isSpoiler: false), postContent: .init(textContent: "Some content...", contentType: .textOnly, media: []), postVoteStatus: .noVote, postFlair: "Some flair", postRecommendedSort: .best))
    
    
    let theme: any Theme = colorScheme == .dark ? EchoDarkTheme() : EchoLightTheme()
    
    ZStack {
        ScrollView {
            VStack(spacing: 0) {
                ListPostView(with: post)
                ListPostView(with: post)
                ListPostView(with: post)
            }
        }
        .listStyle(.plain)
        .listRowSpacing(8)
        .scrollContentBackground(.hidden)
    }
    .environment(\.theme, theme)
}
