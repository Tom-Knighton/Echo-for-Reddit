//
//  PostView.swift
//  Posts
//
//  Created by Tom Knighton on 11/04/2025.
//

import Design
import Env
import SwiftUI
import ComposableArchitecture
import Models
import RedditMarkdownView

public struct PostView: View {

    @Environment(\.theme) private var theme
    @State var store: StoreOf<PostFeature>
    
    public init(postId: String) {
        _store = State(wrappedValue: StoreOf<PostFeature>(initialState: PostFeature.State()) { PostFeature() })
        store.send(.fetchPost(postId: postId))
    }
    
    public init(with post: Post) {
        _store = State(wrappedValue: StoreOf<PostFeature>(initialState: PostFeature.State()) { PostFeature() })
        store.send(.loadPost(post))
    }

    public var body: some View {
        ZStack {
            theme.primaryBackground.ignoresSafeArea()
            
            if store.isLoading {
                ProgressView()
            }
            
            if let post = store.post {
                postView(post)
            }
        }
    }
    
    @ViewBuilder
    private func postView(_ post: Post) -> some View {
        List {
            PostContentView(post: post)
                .listRowInsets(.all, 0)
                .listRowSeparator(.hidden)
                .listRowBackground(Color.clear)
        }
        .listStyle(.plain)
        .scrollContentBackground(.hidden)
    }
}

#Preview {
    @Previewable @Environment(\.colorScheme) var colorScheme
    let theme: any Theme = colorScheme == .dark ? EchoDarkTheme() : EchoLightTheme()

    NavigationStack {
        PostView(with: Post(postId: "1", cursorId: "1", postAuthor: "SomeRedditUser", postAuthorFlair: nil, postSubreddit: "UKPolitics", postTitle: "Wow! TIL You could make a Reddit app smelly smelly smelly smelly...", postScore: 100, postScorePercentage: 100, postCommentCount: 100, postCreatedAt: Date(), postEditedAt: nil, subredditIcon: nil, postFlagDetails: .init(isNSFW: false, isSaved: false, isLocked: false, isStickied: false, isArchived: false, isSpoiler: false), postContent: .init(textContent: "Some content...", contentType: .textOnly, media: []), postVoteStatus: .noVote, postFlair: "Some flair", postRecommendedSort: .best, parentPost: Post(postId: "1", cursorId: "1", postAuthor: "SomeRedditUser", postAuthorFlair: nil, postSubreddit: "UKPolitics", postTitle: "Wow! TIL You could make a Reddit app smelly smelly smelly smelly...", postScore: 100, postScorePercentage: 100, postCommentCount: 100, postCreatedAt: Date(), postEditedAt: nil, subredditIcon: nil, postFlagDetails: .init(isNSFW: false, isSaved: false, isLocked: false, isStickied: false, isArchived: false, isSpoiler: false), postContent: .init(textContent: "Some content...", contentType: .textOnly, media: []), postVoteStatus: .noVote, postFlair: "Some flair", postRecommendedSort: .best)))
    }
    .environment(\.theme, theme)
        
}
