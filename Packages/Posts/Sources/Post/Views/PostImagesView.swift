//
//  PostImagesView.swift
//  Posts
//
//  Created by Tom Knighton on 09/07/2025.
//

import Foundation
import Env
import SwiftUI
import Models
import Design

public struct PostImagesView: View {
    
    private let content: PostContent
    
    public init(with postContent: PostContent) {
        self.content = postContent
    }
    
    public var body: some View {
        VStack {
            if content.contentType == .mediaGallery {
                
                if content.media.count == 1, let first = content.media.first {
                    CachedAsyncImage(url: first.url)
                }
                
                if content.media.count > 1 {
                    MultiImageView {
                        ForEach(content.media) { media in
                            CachedAsyncImage(url: media.url)
                        }
                    }
                }
            }
        }
    }
}

struct MultiImageView<Content: View>: View {
    var config = Config()
    @ViewBuilder var content: Content
    @Namespace private var animation
    
    @State private var isPresented: Bool = false
    @State private var activeTabId: Subview.ID?
    @State private var transitionSource: Int = 0
    
    public var body: some View {
        Group(subviews: content) { collection in
            
            let cutoff = collection.count < 4 ? 2 : 4
            let height = collection.count < 4 ? config.height * 1.5 : config.height
            
            LazyVGrid(columns: Array(repeating: GridItem(spacing: config.spacing), count: 2), spacing: config.spacing) {
                
                let remainingCount = max(collection.count - cutoff, 0)
                ForEach(collection.prefix(cutoff)) { item in
                    let index = collection.index(item.id)
                    GeometryReader {
                        let size = $0.size
                        
                        item
                            .aspectRatio(contentMode: .fill)
                            .frame(width: size.width, height: size.height)
                            .clipShape(.rect(cornerRadius: config.cornerRadius))
                        
                        if remainingCount > 0 && collection.prefix(cutoff).last?.id == item.id {
                            RoundedRectangle(cornerRadius: config.cornerRadius)
                                .fill(.black.opacity(0.45))
                                .overlay(
                                    Text("+\(remainingCount)")
                                        .font(.largeTitle)
                                        .fontWeight(.semibold)
                                        .foregroundStyle(.white)
                                )
                            
                            
                        }
                    }
                    .frame(height: height)
                    .frame(maxWidth: .infinity)
                    .onTapGesture {
                        self.activeTabId = item.id
                        self.isPresented = true
                        self.transitionSource = index
                    }
                    .matchedTransitionSource(id: index, in: animation) { config in
                        config
                            .clipShape(.rect(cornerRadius: self.config.cornerRadius))
                    }
                }
            }
            .navigationDestination(isPresented: $isPresented) {
                TabView(selection: $activeTabId) {
                    ForEach(collection) { item in
                        item
                            .aspectRatio(contentMode: .fit)
                            .zoomable()
                            .tag(item.id)
                    }
                }
                .tabViewStyle(.page)
                .background {
                    Rectangle()
                        .fill(.black)
                        .ignoresSafeArea()
                }
                .navigationTransition(.zoom(sourceID: transitionSource, in: animation))
                .toolbarVisibility(.hidden, for: .navigationBar)
                .toolbarVisibility(.hidden, for: .tabBar)
                .onChange(of: self.activeTabId) { _, new in
                    if let new {
                        transitionSource = min(collection.index(new), cutoff - 1)
                    }
                }
            }
        }
    }
    
    struct Config {
        var height: CGFloat = 150
        var cornerRadius: CGFloat = 10
        var spacing: CGFloat = 10
    }
}

extension SubviewsCollection {
    func index(_ id: SubviewsCollection.Element.ID) -> Int {
        firstIndex(where: { $0.id == id }) ?? 0
    }
}



#Preview {
    @Previewable @Environment(\.colorScheme) var colorScheme
    let theme: any Theme = colorScheme == .dark ? EchoDarkTheme() : EchoLightTheme()
    
    NavigationStack {
        List {
            ListPostView(with: Post(postId: "1", cursorId: "1", postAuthor: "SomeRedditUser", postAuthorFlair: nil, postSubreddit: "UKPolitics", postTitle: "Wow! TIL You could make a Reddit app smelly smelly smelly smelly...", postScore: 100, postScorePercentage: 100, postCommentCount: 100, postCreatedAt: Date(), postEditedAt: nil, subredditIcon: nil, postFlagDetails: .init(isNSFW: false, isSaved: false, isLocked: false, isStickied: false, isArchived: false, isSpoiler: false), postContent: .init(textContent: "Some content...", contentType: .mediaGallery, media: [
                .init(url: "https://i.imgur.com/rifIK8t.jpeg", thumbnailUrl: "https://i.imgur.com/rifIK8t.jpg?fb", height: 1334, width: 750, hlsDashUrl: nil, mediaText: nil, isInline: false, type: .image),
                .init(url: "https://i.imgur.com/dPn7LT9.jpeg", thumbnailUrl: "https://i.imgur.com/rifIK8t.jpg?fb", height: 1334, width: 750, hlsDashUrl: nil, mediaText: nil, isInline: false, type: .image)
            ]), postVoteStatus: .noVote, postFlair: "Some flair", postRecommendedSort: .best, parentPost: nil))
            .listRowSeparator(.hidden)
            .listRowInsets(.all, 0)
        }
        .listStyle(.plain)
        .navigationLinkIndicatorVisibility(.hidden)
        
    }
    .environment(\.theme, theme)
}
