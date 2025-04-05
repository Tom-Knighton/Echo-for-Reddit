//
//  URL+Echo.swift
//  Env
//
//  Created by Tom Knighton on 29/03/2025.
//
import Foundation

public extension URL {
    
    func extractSubreddit() -> String? {
        return self.absoluteString.extractSubreddit()
    }
}
