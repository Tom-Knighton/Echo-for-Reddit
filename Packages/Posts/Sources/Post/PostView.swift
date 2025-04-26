//
//  PostView.swift
//  Posts
//
//  Created by Tom Knighton on 11/04/2025.
//

import SwiftUI
import ComposableArchitecture
import Models
import RedditMarkdownView

public struct PostView: View {

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
        VStack {
            if store.isLoading {
                ProgressView()
            }
            
            if let post = store.post {
                postView(post)
            }
        }
        .navigationTitle("0 Comments")
        .navigationBarTitleDisplayMode(.inline)
        .customNavigation()
    }
    
    @ViewBuilder
    private func postView(_ post: Post) -> some View {
        PostCollectionView(post: post)
    }
}

#Preview {
    PostView(postId: "test")
        
}
