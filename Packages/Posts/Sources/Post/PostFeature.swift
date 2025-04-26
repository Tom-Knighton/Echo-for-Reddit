//
//  PostFeature.swift
//  Posts
//
//  Created by Tom Knighton on 11/04/2025.
//

import ComposableArchitecture
import Models
import API

@Reducer
struct PostFeature {
    
    @ObservableState
    struct State {
        var post: Post?
        var isLoading: Bool = true
        var error: String?
    }
    
    enum Action {
        case loadPost(_ post: Post)
        case fetchPost(postId: String)
        case postLoaded(Result<Post, Error>)
        case dismissError
    }
    
    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .loadPost(let post):
                return .send(.postLoaded(.success(post)))
                
            case .fetchPost(let postId):
                // TODO: Implement fetch post logic
                return .none
                
            case .postLoaded(.success(let post)):
                state.post = post
                state.isLoading = false
                state.error = nil
                return .none
                
            case .postLoaded(.failure(let error)):
                state.error = error.localizedDescription
                return .none
                
            case .dismissError:
                state.error = nil
                return .none
            }
        }
    }
}
