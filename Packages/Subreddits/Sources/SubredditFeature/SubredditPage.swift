//
//  SubredditPage.swift
//  Subreddits
//
//  Created by Tom Knighton on 04/02/2025.
//

import SwiftUI
import Env
import Design
import ComposableArchitecture
import Posts
import Models

public struct SubredditPage: View {
    
    @Environment(\.theme) private var theme
    let store = StoreOf<SubredditFeature>(initialState: SubredditFeature.State()) { SubredditFeature() }
    
    private let subredditName: String
    
    public init(subredditName: String) {
        self.subredditName = subredditName
    }
    
    public var body: some View {
        ZStack {
            if store.isLoading {
                theme.primaryBackground.ignoresSafeArea()
                ProgressView()
            }
            
            if let error = store.error {
                theme.primaryBackground.ignoresSafeArea()
                Text(error)
            }
            
            if let subreddit = store.state.subredditData {
                subredditView(for: subreddit)
            }
        }
        .ignoresSafeArea(.container, edges: [.bottom])
        .navigationTitle(store.state.subredditData?.subredditName ?? "")
        .navigationSubtitle(store.state.subredditData?.subredditTitle ?? "")
        .task {
            store.send(.fetchInitialData(subredditName: subredditName))
        }
    }
    
    @State private var search: String = ""
    
    @ViewBuilder
    private func subredditView(for subreddit: Subreddit) -> some View {
        List {
            ForEach(store.posts) { post in
                ListPostView(with: post)
                    .equatable()
                    .id(post.postId)
                    .listRowInsets(.all, 0)
                    .listRowSeparator(.hidden)
                    .listRowBackground(Color.clear)
            }
        }
        .navigationLinkIndicatorVisibility(.hidden)
        .listStyle(.plain)
        .listRowSpacing(8)
        .background(theme.primaryBackground)
        .scrollContentBackground(.hidden)
        .customNavigation(with: {
            if let avatarURL = URL(string: subreddit.subredditIconUrl ?? "") {
                AsyncImage(url: avatarURL) { phase in
                    switch phase {
                    case .success(let image):
                        image
                            .resizable()
                            .frame(width: 44, height: 44)
                            .scaledToFit()
                            .clipShape(Circle())
                            .shadow(radius: 3)
                    default:
                        Circle()
                            .fill(Color.gray)
                    }
                }
            }
        }, title: store.state.subredditData?.subredditName ?? "", backgroundUrl: subreddit.bannerImageUrl)
    }
}
