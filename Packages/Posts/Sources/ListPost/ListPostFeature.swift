//
//  ListPostFeature.swift
//  Posts
//
//  Created by Tom Knighton on 04/02/2025.
//

import Foundation
import Models
import ComposableArchitecture
import Design
import Env

@Reducer
struct PostListFeature {
    
    @ObservableState
    struct State {
        var post: Post?
        var data: OpenGraphData?
        var dataFailed: Bool = false
        var isLoading: Bool = false
        var error: String? = nil
    }
    
    enum Action {
        case loadPost(_ post: Post)
        case fetchPost(postId: String)
        case postLoaded(Result<(Post, OpenGraphData?), Error>)
        case dismissError
    }
    
    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case let .loadPost(post):
                return .run { send in
                    if post.postContent.contentType == .linkOnly, let url = URL(string: post.postContent.media.first?.url ?? "") {
                        let data = try? await LPMetadataManager.shared.metadata(for: url)
                        await send(.postLoaded(.success((post, data))))
                    } else {
                        await send(.postLoaded(.success((post, nil))))
                    }
                    
                }
            case let .postLoaded(.success((post, data))):
                state.post = post
                state.data = data
                state.dataFailed = data == nil
                state.isLoading = false
                state.error = nil
                return .none
            default:
                return .none
            }
        }
    }
}
