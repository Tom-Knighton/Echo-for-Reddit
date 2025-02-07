//
//  SubredditPage.swift
//  Subreddits
//
//  Created by Tom Knighton on 04/02/2025.
//

import SwiftUI
import Env
import ComposableArchitecture
import Posts
import Models
import SwiftUIIntrospect

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
    
    @State private var search: String = ""
    
    @ViewBuilder
    private func subredditView(for subreddit: Subreddit) -> some View {
        List {
            Color.clear
                .frame(height: 3)
                .listRowInsets(.init())
                .listRowBackground(theme.primaryBackground)
                .listRowSeparator(.hidden)
            ForEach(store.posts) { post in
                ListPostView(with: post)
            }
        }
        .searchable(text: $search)
        .environment(\.defaultMinListRowHeight, 3)
        .listStyle(.plain)
        .listRowSpacing(12)
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
        .introspect(.searchField, on: .iOS(.v18), scope: .ancestor) { searchField in
            searchField.searchTextField.textColor = UIColor(theme.labelColor)
            searchField.searchTextField.leftView?.tintColor = .gray
            if let textField = searchField.value(forKey: "searchField") as? UITextField {
                let placeholder = textField.value(forKey: "placeholderLabel") as? UILabel
                placeholder?.textColor = .gray
            }
        }
    }
}
