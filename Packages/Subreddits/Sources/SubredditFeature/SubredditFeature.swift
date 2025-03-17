//
//  SubredditFeature.swift
//  Subreddits
//
//  Created by Tom Knighton on 04/02/2025.
//

import API
import Env
import Foundation
import ComposableArchitecture
import Models
import Combine
import Design

@Reducer
public struct SubredditFeature {
    
    @ObservableState
    public struct State : Sendable {
        var subredditData: Subreddit? = nil
        var posts: [Post] = []
        var openGraphData: [String: OpenGraphData?] = [:]
        var isLoading: Bool = false
        var error: String? = nil
    }
    
    public enum Action {
        case fetchInitialData(subredditName: String)
        case fetchNextPosts
        case initialDataLoaded(Result<EchoAPI.GetSubredditQuery.Data.Reddit.Subreddit, Error>)
        case dismissError
        case postsFetched(Result<[EchoAPI.GetSubredditPostsQuery.Data.Reddit.Subreddit.Posts.Edge.Node], Error>)
    }
    
    public struct DataSourceLoadMoreID: Hashable {}
    
    public var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .fetchInitialData(let subredditName):
                state.isLoading = true
                return .run(operation: { send in
                    do {
                        let result = try await GQLClient().query(EchoAPI.GetSubredditQuery(name: subredditName))
                        await send(.initialDataLoaded(.success(result.reddit.subreddit)))
                    } catch (let error) {
                        await send(.initialDataLoaded(.failure(error)))
                    }
                })
            case .fetchNextPosts:
                guard let subreddit = state.subredditData else {
                    state.error = "Failed loading posts: T1"
                    return .none
                }
                
                let sort: RedditSortOption = .hot //TODO: Read default from subreddit data
                
                return .run { send in
                    do {
                        let response = try await GQLClient().query(EchoAPI.GetSubredditPostsQuery(after: .init(stringLiteral: ""), subredditName: subreddit.subredditName, sort: .init(sort.toGQL())))
                        let posts = response.reddit.subreddit.posts?.edges?.compactMap { $0.node }
                        await send(.postsFetched(.success(posts ?? [])))
                    } catch (let error) {
                        await send(.postsFetched(.failure(error)))
                    }
                }
            case .dismissError:
                state.error = nil
                return .none
                
                // Responses
            case .initialDataLoaded(.success(let data)):
                state.subredditData = Subreddit(from: data)
                state.isLoading = false
                state.error = nil
                return .send(.fetchNextPosts)
            case .initialDataLoaded(.failure(let error)):
                state.error = error.localizedDescription
                state.isLoading = false
                return .none
                
            case .postsFetched(.success(let postNodes)):
                let newPosts = postNodes.compactMap { Post(from: $0) }
                let existingIDs = Set(state.posts.map { $0.postId })
                let postsToAppend = newPosts.filter { !existingIDs.contains($0.postId) }
                state.posts.append(contentsOf: postsToAppend)
                
                return .run { send in
                    await withTaskGroup(of: OpenGraphData?.self) { group in
                        for post in postsToAppend.filter({ $0.postContent.contentType == .linkOnly }) {
                            if let url = URL(string: post.postContent.media.first?.url ?? "") {
                                group.addTask {
                                    return try? await LPMetadataManager.shared.metadata(for: url)
                                }
                            }
                        }
                    }
                }
            case .postsFetched(.failure(let error)):
                state.error = error.localizedDescription
                return .none
            }
        }
    }
}
