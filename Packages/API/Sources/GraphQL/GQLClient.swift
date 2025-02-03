//
//  ApolloClient.swift
//  API
//
//  Created by Tom Knighton on 29/01/2025.
//
import Foundation
import ConcurrencyExtras
@preconcurrency import Apollo

class AuthorizationInterceptor: ApolloInterceptor {
    public var id: String = UUID().uuidString
    
    func interceptAsync<Operation>(
        chain: RequestChain,
        request: HTTPRequest<Operation>,
        response: HTTPResponse<Operation>?,
        completion: @escaping (Result<GraphQLResult<Operation.Data>, Error>) -> Void
    ) where Operation : GraphQLOperation {
        getToken { token in
            if let token {
                request.addHeader(name: "Authorization", value: "Bearer \(token)")
            }
        
            chain.proceedAsync(
                request: request,
                response: response,
                interceptor: self,
                completion: completion)
        }
    }
    
    private func getToken(callback: @escaping (String?) -> Void) {
        let sendableCallback = unsafeBitCast(callback, to: (@Sendable (String?) -> Void).self)
        Task {
            let token = try? await AuthManager().validToken()
            sendableCallback(token?.Token)
        }
    }
    
}

class NetworkInterceptorProvider: DefaultInterceptorProvider {
    
    override func interceptors<Operation>(for operation: Operation) -> [ApolloInterceptor] where Operation : GraphQLOperation {
        var interceptors = super.interceptors(for: operation)
        interceptors.insert(AuthorizationInterceptor(), at: 0)
        return interceptors
    }
    
}

public struct GQLClient {
    private(set) var apolloClient: ApolloClient = {
        let client = URLSessionClient()
        let cache = InMemoryNormalizedCache()
        let store = ApolloStore(cache: cache)
        let provider = NetworkInterceptorProvider(client: client, store: store)
        let url = URL(string: "https://api.dev.garydit.tomk.online/graphql")
        let transport = RequestChainNetworkTransport(interceptorProvider: provider, endpointURL: url!)
        
        return ApolloClient(networkTransport: transport, store: store)
    }()
    
    public init() {}
    
    public func query<Query: GraphQLQuery>(_ query: Query) async throws -> Query.Data {
        let result = try await apolloClient.fetch(query: query).data
        guard let result else {
            throw APIError.couldNotParse
        }
        
        return result
    }
}
