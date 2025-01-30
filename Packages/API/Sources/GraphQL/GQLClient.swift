//
//  ApolloClient.swift
//  API
//
//  Created by Tom Knighton on 29/01/2025.
//
import Foundation
import Apollo

public struct GQLClient {
    let apolloClient = ApolloClient(url: URL(string: "http://localhost:7276/graphql")!)
    
    public func query<Query: GraphQLQuery>(_ query: Query) async throws -> Query.Data {
        let result = try await apolloClient.fetch(query: query).data
        guard let result else {
            throw APIError.couldNotParse
        }
        
        return result
    }
}
