//
//  PostDetailsView.swift
//  Posts
//
//  Created by Tom Knighton on 08/02/2025.
//
import SwiftUI
import Models

struct PostDetailsView: View {
    
    @Environment(\.theme) private var theme
    let post: Post
    
    public var body: some View {
        Spacer().frame(height: 6)
        HStack {
            VStack(alignment: .leading) {
                Text("by ")
                    .font(.subheadline)
                + Text(post.postAuthor)
                    .bold()
                    .font(.subheadline)

                Spacer().frame(height: 6)
                HStack {
                    HStack(spacing: 3) {
                        Image(systemName: "arrow.up")
                        Text(String(describing: post.postScore))
                    }
                    HStack(spacing: 3) {
                        Image(systemName: "message")
                        Text(String(describing: post.postCommentCount))
                    }
                    HStack(spacing: 3) {
                        Image(systemName: "clock")
                        Text(post.postCreatedAt.friendlyAgo)
                    }
                }
                .font(.footnote)
            }
            
            Spacer()
            
            Button(action: {}) {
                Image(systemName: "ellipsis")
            }
            Button(action: {}) {
                Image(systemName: "arrow.up")
            }
            Button(action: {}) {
                Image(systemName: "arrow.down")
            }
        }
        .frame(maxWidth: .infinity)
        .foregroundStyle(theme.labelColor.secondary)
    }
}
