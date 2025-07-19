//
//  SubredditListPage.swift
//  Subreddits
//
//  Created by Tom Knighton on 03/02/2025.
//

import ComposableArchitecture
import SwiftUI
import API
import Env

public struct SubredditListPage: View {
    
    @Environment(\.theme) private var theme
    @State var store = StoreOf<SubredditListFeature>(initialState: SubredditListFeature.State()) { SubredditListFeature() }

    public init() {}
    
    public var body: some View {
        ZStack {
            theme.primaryBackground.ignoresSafeArea()
            
            if store.isLoading {
                ProgressView()
            }
            
            List {
                Section("Reddit:") {
                    redditRow(subredditTitle: "All", desc: "Posts from all subreddits", imageName: "signpost.right.and.left.fill", subredditName: "all")
                    redditRow(subredditTitle: "Popular", desc: "Curated popular posts from across Reddit", imageName: "chart.line.uptrend.xyaxis", subredditName: "popular")
                    redditRow(subredditTitle: "Home", desc: "Posts from your subscribed subreddits", imageName: "house.fill", subredditName: "home")
                }
                .multilineTextAlignment(.leading)
                
                ForEach(store.subscribed.keys.sorted(), id: \.self) { key in
                    Section(key) {
                        ForEach(store.subscribed[key] ?? []) { subreddit in
                            listRow(for: subreddit)
                        }
                    }
                    .sectionIndexLabel(key)
                }
            }
            .scrollContentBackground(.hidden)
        }
        .task {
            if store.subscribed.isEmpty {
                store.send(.fetchSubscribed)
            }
        }
        .navigationTitle("Subreddits")
        .customNavigation(title: "Subreddits")
    }
    
    @ViewBuilder
    private func listRow(for subreddit: EchoAPI.SubscribedSubredditFragment) -> some View {
        NavigationLink(value: RouterDestination.subreddit(subredditName: subreddit.subredditName)) {
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
                
                Text(subreddit.subredditName)
            }
        }
    }
    
    @ViewBuilder
    private func redditRow(subredditTitle: String, desc: String, imageName: String, subredditName: String) -> some View {
        NavigationLink(value: RouterDestination.subreddit(subredditName: subredditName)) {
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
}
