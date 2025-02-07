//
//  SubredditListPage.swift
//  Subreddits
//
//  Created by Tom Knighton on 03/02/2025.
//

import ComposableArchitecture
import SwiftUI
import API

public struct SubredditListPage: View {
    
    @Environment(\.theme) private var theme
    let store = StoreOf<SubredditListFeature>(initialState: SubredditListFeature.State()) { SubredditListFeature() }

    public init() {}
    
    public var body: some View {
        ZStack {
            theme.primaryBackground.ignoresSafeArea()
            
            if store.isLoading {
                ProgressView()
            }
            
            List {
                Section("Reddit:") {
                    redditRow(subredditName: "All", desc: "Posts from all subreddits", imageName: "signpost.right.and.left.fill")
                    redditRow(subredditName: "Popular", desc: "Curated popular posts from across Reddit", imageName: "chart.line.uptrend.xyaxis")
                    redditRow(subredditName: "Home", desc: "Posts from your subscribed subreddits", imageName: "house.fill")
                }
                .multilineTextAlignment(.leading)
                
                
                ForEach(store.subscribed.keys.sorted(), id: \.self) { key in
                    Section(key) {
                        ForEach(store.subscribed[key] ?? []) { subreddit in
                            listRow(for: subreddit)
                        }
                    }
                }
            }
            .scrollContentBackground(.hidden)
        }
        .task {
            store.send(.fetchSubscribed)
        }
        .navigationTitle("Subreddits")
        .customNavigation()
    }
    
    @ViewBuilder
    private func listRow(for subreddit: EchoAPI.SubscribedSubredditFragment) -> some View {
        HStack {
            if let avatarURL = URL(string: subreddit.subredditIconUrl ?? "") {
                AsyncImage(url: avatarURL) { phase in
                    switch phase {
                    case .success(let image):
                        image
                            .resizable()
                            .frame(width: 25, height: 25)
                            .scaledToFit()
                            .clipShape(Circle())
                            .shadow(radius: 3)
                    default:
                        Circle()
                            .fill(Color.gray)
                            .frame(width: 25, height: 25)
                    }
                }
            } else {
                Circle()
                    .fill(Color.gray)
                    .frame(width: 25, height: 25)
            }
            
            Text(subreddit.subredditTitle)
        }
    }
    
    @ViewBuilder
    private func redditRow(subredditName: String, desc: String, imageName: String) -> some View {
        HStack {
            Image(systemName: imageName)
            VStack {
                Text(subredditName)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text(desc)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.caption)
            }
        }
    }
}
