//
//  SubredditListFeature.swift
//  Subreddits
//
//  Created by Tom Knighton on 03/02/2025.
//

import API
import ComposableArchitecture

@Reducer
struct SubredditListFeature {
    
    @ObservableState
    struct State: Equatable {
        var subscribed: [String: [EchoAPI.SubscribedSubredditFragment]] = [:]
        var isLoading: Bool = false
        var error: String? = nil
    }
    
    enum Action {
        case fetchSubscribed
        case subscribedLoaded(Result<[EchoAPI.SubscribedSubredditFragment], Error>)
        case dismissError
    }
    
    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .fetchSubscribed:
                return .run { send in
                    do {
                        let user = try await GQLClient().query(EchoAPI.GetSubscribedSubredditsQuery())
                        await send(.subscribedLoaded(.success(user.reddit.subscribed.compactMap { $0.fragments.subscribedSubredditFragment })))
                    } catch(let error) {
                        await send(.subscribedLoaded(.failure(error)))
                    }
                }
                
            case .dismissError:
                state.error = nil
                return .none
                // Responses
            case .subscribedLoaded(.success(let subreddits)):
                let groupedDictionary = Dictionary(grouping: subreddits) { obj in
                    String(obj.subredditName.prefix(1)).uppercased()
                }
                state.subscribed = groupedDictionary.mapValues { group in
                    group.sorted(by: { $0.subredditTitle < $1.subredditTitle })
                }
                state.isLoading = false
                state.error = nil
                return .none
            case .subscribedLoaded(.failure(let error)):
                state.error = error.localizedDescription
                state.isLoading = false
                return .none
            }
        }
    }
}
