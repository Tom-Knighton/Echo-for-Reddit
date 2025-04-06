//
//  PostDetailsView.swift
//  Posts
//
//  Created by Tom Knighton on 08/02/2025.
//
import SwiftUI
import Models
import Env

struct PostDetailsView: View {
    
    @Environment(\.theme) private var theme
    let post: Post
    let isCrossPost: Bool
    
    init(_ post: Post, isCrossPost: Bool = false) {
        self.post = post
        self.isCrossPost = isCrossPost
    }
    
    public var body: some View {
        Spacer().frame(height: 6)
        HStack {
            layout {
                inOrByDetails()
                Spacer().frame(height: 6)
                HStack {
                    HStack(spacing: 3) {
                        Image(systemName: "arrow.up")
                        Text(post.postScore.toFriendly())
                            .fixedSize()
                    }
                    HStack(spacing: 3) {
                        Image(systemName: "message")
                        Text(post.postCommentCount.toFriendly())
                            .fixedSize()
                    }
                    HStack(spacing: 3) {
                        Image(systemName: "clock")
                        Text(post.postCreatedAt.friendlyAgo)
                            .fixedSize()
                    }
                }
                .font(.footnote)
            }
            
            if !isCrossPost {
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
        }
        .frame(maxWidth: .infinity)
        .foregroundStyle(theme.labelColor.secondary)
    }
    
    @ViewBuilder
    private func inOrByDetails() -> some View {
        HStack {
            if isCrossPost {
                Image(systemName: "arrow.trianglehead.branch")
                    .rotationEffect(.degrees(90))
                Text(post.postSubreddit)
                    .bold()
                    .fixedSize()
            } else {
                Text("by ")
                + Text(post.postAuthor)
                    .bold()
            }
        }
        .fixedSize()
        .font(.subheadline)
    }
    
    @ViewBuilder private func layout<Content: View>(@ViewBuilder content: () -> Content) -> some View {
        Group {
            if isCrossPost{
                HStack(content: content)
            } else {
                VStack(alignment: .leading, content: content)
            }
        }
    }
}
