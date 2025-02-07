//
//  ListPostFeature.swift
//  Posts
//
//  Created by Tom Knighton on 04/02/2025.
//

import Models
import ComposableArchitecture

@Reducer
struct PostListFeature {
    
    @ObservableState
    struct State {
        var post: Post?
        var isLoading: Bool = false
        var error: String? = nil
    }
    
    enum Action {
        case loadPost(_ post: Post)
        case fetchPost(postId: String)
        case postLoaded(Result<String, Error>)
        case dismissError
    }
    
    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case let .loadPost(post):
                state.post = post
                state.isLoading = false
                state.error = nil
                return .none
            default:
                return .none
            }
        }
    }
}
