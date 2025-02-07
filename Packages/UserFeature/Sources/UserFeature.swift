//
//  UserFeature.swift
//  UserFeature
//
//  Created by Tom Knighton on 30/01/2025.
//

import API
import ComposableArchitecture
import Models

@Reducer
struct UserFeature {
    
    @ObservableState
    struct State: Equatable {
        var user: User? = nil
        var userSubreddit: UserSubreddit? = nil
        var isLoading: Bool = false
        var error: String? = nil
    }
    
    enum Action {
        case fetchMe
        case fetchUser(String)
        case userLoaded(Result<EchoAPI.GetCurrentUserQuery.Data.Reddit.Me, Error>)
        case dismissError
    }
    
    
    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .fetchMe:
                return .run { send in
                    do {
                        let user = try await GQLClient().query(EchoAPI.GetCurrentUserQuery())
                        await send(.userLoaded(.success(user.reddit.me)))
                    } catch(let error) {
                        await send(.userLoaded(.failure(error)))
                    }
                }
                
            case .dismissError:
                state.error = nil
                return .none
            // Responses
            case .userLoaded(.success(let user)):
                state.user = .init(from: user)
                state.userSubreddit = UserSubreddit(from: user.userSubreddit)
                state.isLoading = false
                state.error = nil
                return .none
            case .userLoaded(.failure(let error)):
                state.user = nil
                print(error)
                state.error = error.localizedDescription
                state.isLoading = false
                return .none
            default:
                return .none
            }
        }
    }
}
