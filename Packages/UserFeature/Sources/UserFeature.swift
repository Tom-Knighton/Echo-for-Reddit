//
//  UserFeature.swift
//  UserFeature
//
//  Created by Tom Knighton on 30/01/2025.
//

import API
import ComposableArchitecture

@Reducer
struct UserFeature {
    
    @ObservableState
    struct State: Equatable {
        var user: EchoAPI.UserFragment? = nil
        var isLoading: Bool = false
        var error: String? = nil
    }
    
    enum Action {
        case fetchMe
        case fetchUser(String)
        case userLoaded(Result<EchoAPI.UserFragment, Error>)
        case dismissError
    }
    
    
    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .fetchMe:
                return .run { send in
                    do {
                        let user = try await GQLClient().query(EchoAPI.GetCurrentUserQuery())
                        await send(.userLoaded(.success(user.reddit.me.fragments.userFragment)))
                    } catch(let error) {
                        await send(.userLoaded(.failure(error)))
                    }
                }
                
            case .dismissError:
                state.error = nil
                return .none
            // Responses
            case .userLoaded(.success(let user)):
                state.user = user
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
