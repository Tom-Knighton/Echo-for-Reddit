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

public struct ListPostView: View {
    
    @Environment(\.theme) private var theme
    let store: StoreOf<PostListFeature>
    
    public init() {
        store = StoreOf<PostListFeature>(initialState: PostListFeature.State()) { PostListFeature() }
    }
    
    public init(with post: Post) {
        store = StoreOf<PostListFeature>(initialState: PostListFeature.State(post: post)) { PostListFeature() }
        store.send(.loadPost(post))
    }
    
    public var body: some View {
        ZStack {
            if store.isLoading {
                ProgressView()
            }
            
            if let post = store.post {
                postView(for: post)
            } else {
                Text("no post")
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .listRowInsets(.init())
        .listRowBackground(theme.layer2)
        .listRowSeparator(.hidden)
        .fontDesign(.rounded)
    }
    
    @ViewBuilder
    private func postView(for post: Post) -> some View {
        VStack {
            Text(post.postTitle)
                .font(.headline)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            if post.postContent.contentType == .textOnly, let textContent = post.postContent.textContent, !textContent.isEmpty {
                Spacer().frame(height: 4)
                Text(textContent.truncate(length: 150))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundStyle(theme.labelColor.secondary)
            }
            
            postDetails(for: post)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 12)
        .padding(.vertical, 12)
        .multilineTextAlignment(.leading)
    }
    
    @ViewBuilder
    private func postDetails(for post: Post) -> some View {
        Spacer().frame(height: 6)
        HStack {
            VStack(alignment: .leading) {
                Text("by ")
                    .font(.subheadline)
                + Text(post.postAuthor)
                    .bold()
                    .font(.subheadline)

                Spacer().frame(height: 6)
                HStack {
                    HStack(spacing: 3) {
                        Image(systemName: "arrow.up")
                        Text(String(describing: post.postScore))
                    }
                    HStack(spacing: 3) {
                        Image(systemName: "message")
                        Text(String(describing: post.postCommentCount))
                    }
                    HStack(spacing: 3) {
                        Image(systemName: "clock")
                        Text(post.postCreatedAt.friendlyAgo)
                    }
                }
                .font(.footnote)
            }
            
            Spacer()
            
            Button(action: {}) {
                Image(systemName: "ellipsis")
            }
            Button(action: {}) {
                Image(systemName: "arrow.up")
            }
            Button(action: {}) {
                Image(systemName: "arrow.down")
            }
        }
        .frame(maxWidth: .infinity)
        .foregroundStyle(theme.labelColor.secondary)
    }
}

#Preview {
    @Previewable @Environment(\.colorScheme) var colorScheme
    let post = Post(postId: "1", cursorId: "1", postAuthor: "SomeRedditUser", postAuthorFlair: nil, postSubreddit: "UKPolitics", postTitle: "Wow! TIL You could make a Reddit app smelly smelly smelly smelly...", postScore: 100, postScorePercentage: 100, postCommentCount: 100, postCreatedAt: Date(), postEditedAt: nil, subredditIcon: nil, postFlagDetails: .init(isNSFW: false, isSaved: false, isLocked: false, isStickied: false, isArchived: false, isSpoiler: false), postContent: .init(textContent: "Some content...", contentType: .textOnly, media: []), postVoteStatus: .noVote, postFlair: "Some flair", postRecommendedSort: .best)
    
    let theme: any Theme = colorScheme == .dark ? EchoDarkTheme() : EchoLightTheme()

    ZStack {
        List {
            ListPostView(with: post)
            ListPostView(with: post)
            ListPostView(with: post)
        }
        .listStyle(.plain)
        .listRowSpacing(8)
        .scrollContentBackground(.hidden)
    }
    .environment(\.theme, theme)
}
    
