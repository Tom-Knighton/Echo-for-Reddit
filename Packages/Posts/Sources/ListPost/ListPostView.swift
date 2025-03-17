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
    
    public init() {
        store = StoreOf<PostListFeature>(initialState: PostListFeature.State()) { PostListFeature() }
    }
    
    public init(with post: Post) {
        store = StoreOf<PostListFeature>(initialState: PostListFeature.State(post: post)) { PostListFeature() }
        store.send(.loadPost(post))
    }
    
    public var body: some View {
        VStack(spacing: 0) {
            ZStack {
                if store.isLoading {
                    ProgressView()
                }
                
                if let post = store.post {
                    postView(for: post)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(theme.primaryBackground)
            .fontDesign(.rounded)
            
            Rectangle()
                .fill(theme.layer2)
                .frame(height: 12)
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
            
            if post.postContent.contentType == .linkOnly {
                if let linkData = store.data {
                    OGLinkView(data: linkData)
                } else if store.dataFailed {
                    HStack {
                        Image(systemName: "network")
                        Divider()
                        Text(post.postContent.media.first?.url ?? "Visit Link")
                            .lineLimit(1)
                        Spacer()
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(theme.layer3)
                    .clipShape(.rect(cornerRadius: 10))
                    .shadow(radius: 3)
                    .onTapGesture {
                        if store.data == nil, post.postContent.contentType == .linkOnly, let url = URL(string: post.postContent.media.first?.url ?? "") {
                            self.openURL(url)
                        }
                    }
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
           
            
            PostDetailsView(post: post)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 12)
        .padding(.vertical, 12)
        .multilineTextAlignment(.leading)
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
