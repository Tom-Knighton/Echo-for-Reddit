//
//  LPCache.swift
//  Env
//
//  Created by Tom Knighton on 10/02/2025.
//

import Foundation
@preconcurrency import LinkPresentation

@globalActor
public final actor LPMetadataManager {
    
    public static let shared = LPMetadataManager()
    
    private var cache: [URL: LPLinkMetadata] = [:]
    
    public func metadata(for url: URL) async throws -> LPLinkMetadata? {
        if let cached = cache[url] {
            return cached
        }
        
        let provider = LPMetadataProvider()
        let metadata = try? await provider.startFetchingMetadata(for: url)
        if let metadata {
            cache[url] = metadata
        }

        return metadata
    }
    
}
