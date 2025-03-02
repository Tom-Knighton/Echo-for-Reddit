//
//  LPCache.swift
//  Env
//
//  Created by Tom Knighton on 10/02/2025.
//

import Foundation
import Design
@preconcurrency import LinkPresentation
@preconcurrency import OpenGraphReader

@globalActor
public final actor LPMetadataManager {
    
    public static let shared = LPMetadataManager()
    
    private var cache: [URL: OpenGraphData] = [:]
    
    public func metadata(for url: URL) async throws -> OpenGraphData? {
        if let cached = cache[url] {
            return cached
        }
        
        var openGraphResponse = await retrieve(url)
        if openGraphResponse == nil || openGraphResponse?.imageURL == nil {
            openGraphResponse = await retrieve(url, realHeader: true)
        }
        
        if let openGraphResponse {
            let data = OpenGraphData(
                title: openGraphResponse.title,
                link: openGraphResponse.url ?? url,
                type: openGraphResponse.type,
                siteName: openGraphResponse.siteName,
                description: openGraphResponse.description,
                imageURL: openGraphResponse.imageURL
            )
            cache[url] = data
            return data
        }
        
        return nil
    }
    
    private func retrieve(_ url: URL, realHeader: Bool = false) async -> OpenGraphResponse? {
        let provider = OpenGraphReader()
        
        var request = URLRequest(url: url)
        
        if realHeader {
            request.addValue("Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.77 Safari/537.36", forHTTPHeaderField: "User-Agent")
        } else {
            request.addValue("facebookexternalhit/1.1", forHTTPHeaderField: "User-Agent")
        }
        
        let openGraphResponse = try? await provider.fetch(request: request)
        
        return openGraphResponse
    }
    
}
