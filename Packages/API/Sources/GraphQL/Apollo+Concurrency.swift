//
//  Apollo+Concurrency.swift
//  API
//
//  Created by Tom Knighton on 30/01/2025.
//
import Foundation
@preconcurrency import Apollo

extension ApolloClient {
    
    public func fetch<Query: GraphQLQuery>(query: Query) async throws -> GraphQLResult<Query.Data>{
        try await withCheckedThrowingContinuation { continuation in
            self.fetch(query: query, cachePolicy: .returnCacheDataDontFetch) { result in
                switch result {
                case .success(let data):
                    continuation.resume(returning: data)
                    break
                case .failure(let error):
                    continuation.resume(throwing: error)
                    break
                }
            }
        }
    }
}
