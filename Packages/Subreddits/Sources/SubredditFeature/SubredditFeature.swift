//
//  SubredditFeature.swift
//  Subreddits
//
//  Created by Tom Knighton on 04/02/2025.
//

import API
import Foundation
import ComposableArchitecture

typealias SubredditData = EchoAPI.GetSubredditQuery.Data.Reddit.Subreddit

@Reducer
struct SubredditFeature {
    
    @ObservableState
    struct State {
        var subredditData: SubredditData? = nil
        var isLoading: Bool = false
        var error: String? = nil
    }
    
    enum Action {
        case fetchInitialData(subredditName: String)
        case initialDataLoaded(Result<SubredditData, Error>)
        case dismissError
    }
    
    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .fetchInitialData(let subredditName):
                return .run { send in
                    do {
                        let result = try await GQLClient().query(EchoAPI.GetSubredditQuery(name: subredditName))
                        await send(.initialDataLoaded(.success(result.reddit.subreddit)))
                    } catch (let error) {
                        await send(.initialDataLoaded(.failure(error)))
                    }
                }
                
            case .dismissError:
                state.error = nil
                return .none
                
            // Responses
            case .initialDataLoaded(.success(let data)):
                state.subredditData = data
                state.isLoading = false
                state.error = nil
                return .none
            case .initialDataLoaded(.failure(let error)):
                state.error = error.localizedDescription
                state.isLoading = false
                return .none
            }
        }
    }
}
