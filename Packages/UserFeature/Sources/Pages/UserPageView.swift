//
//  UserPageView.swift
//  UserFeature
//
//  Created by Tom Knighton on 01/02/2025.
//

import SwiftUI
import Design
import Env
import Models
import ComposableArchitecture

public struct UserPageView: View {
    
    @Environment(\.theme) private var theme
    let store = StoreOf<UserFeature>(initialState: UserFeature.State()) { UserFeature() }
    
    public init() {}
    
    public var body: some View {
        ZStack {
            theme.primaryBackground.ignoresSafeArea()
            
            if store.isLoading {
                ProgressView()
            }
            
            if let user = store.user, let subreddit = store.userSubreddit {
                userBio(user, subreddit)
            }
            
            if let error = store.error {
                Text(error)
            }
        }
        .task {
            store.send(.fetchMe)
        }
    }
    
    @ViewBuilder
    private func userBio(_ user: User, _ subreddit: UserSubreddit) -> some View {
        ZStack {
            ScrollView {
                VStack {
                    UserStatsView(user: user, userSubreddit: subreddit)
                    if let bio = user.description {
                        UserBioView(description: bio)
                    }
                }
                .padding(.horizontal, 16)
            }
            .navigationTitle(getUserTitle(for: user, subreddit: subreddit))
            .customNavigation(with: {
                if let avatarURL = URL(string: user.iconImageUrl) {
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
            }, title: getUserTitle(for: user, subreddit: subreddit), subtitle: getUserSubtitle(for: user, with: subreddit))
        }
    }
    
    private func getUserTitle(for user: User, subreddit: UserSubreddit) -> String {
        let subredditIsEmpty = subreddit.subredditTitle.isEmpty
        
        return subredditIsEmpty ? user.name : subreddit.subredditTitle
    }
    
    private func getUserSubtitle(for user: User, with subreddit: UserSubreddit) -> String? {
        if let subredditName = subreddit.subredditTitle.isEmpty ? nil : subreddit.subredditTitle {
            return subredditName != user.name ? "u/\(user.name)" : nil
        }
        
        return nil
    }
}
