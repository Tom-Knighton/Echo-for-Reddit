//
//  SubredditPage.swift
//  Subreddits
//
//  Created by Tom Knighton on 04/02/2025.
//

import SwiftUI
import Env
import ComposableArchitecture

public struct SubredditPage: View {
    
    @Environment(\.theme) private var theme
    let store = StoreOf<SubredditFeature>(initialState: SubredditFeature.State()) { SubredditFeature() }
    private let subredditName: String
    
    public init(subredditName: String) {
        self.subredditName = subredditName
    }

    public var body: some View {
        ZStack {
            theme.primaryBackground.ignoresSafeArea()
            
            if store.isLoading {
                ProgressView()
            }
            
            if let error = store.error {
                Text(error)
            }
            
            if let subreddit = store.state.subredditData {
                subredditView(for: subreddit)
            }
        }
        .task {
            store.send(.fetchInitialData(subredditName: subredditName))
        }
    }
    
    @ViewBuilder
    private func subredditView(for subreddit: SubredditData) -> some View {
        List {
            Text("row")
            Text("row")
            Text("row")
            Text("row")
        }
        .listStyle(.plain)
        .scrollContentBackground(.hidden)
        .navigationTitle(subreddit.subredditTitle)
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
        }, backgroundUrl: subreddit.bannerImageUrl)
    }
}
