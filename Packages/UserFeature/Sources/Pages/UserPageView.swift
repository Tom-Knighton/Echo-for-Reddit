//
//  UserPageView.swift
//  UserFeature
//
//  Created by Tom Knighton on 01/02/2025.
//

import SwiftUI
import Design
import Env
import API
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
            
            if let user = store.user {
                userBio(user)
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
    private func userBio(_ user: EchoAPI.UserFragment) -> some View {
        ZStack {
            ScrollView {
                VStack {
                    UserStatsView(user: user)
                    if let bio = user.description {
                        UserBioView(description: bio)
                    }
                }
                .padding(.horizontal, 16)
            }
            .navigationTitle(getUserTitle(for: user))
            .customNavigationTitleWithRightIcon({
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
            }, subtitle: getUserSubtitle(for: user))
        }
    }
    
    private func getUserTitle(for user: EchoAPI.UserFragment) -> String {
        let subredditIsEmpty = user.userSubreddit.subredditTitle.isEmpty
        
        return subredditIsEmpty ? user.name : user.userSubreddit.subredditTitle
    }
    
    private func getUserSubtitle(for user: EchoAPI.UserFragment) -> String? {
        if let subredditName = user.userSubreddit.subredditTitle.isEmpty ? nil : user.userSubreddit.subredditTitle {
            return subredditName != user.name ? "u/\(user.name)" : nil
        }
        
        return nil
    }
}
