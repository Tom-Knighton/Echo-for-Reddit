//
//  Int+Echo.swift
//  Env
//
//  Created by Tom Knighton on 06/04/2025.
//

extension Int {
    
    /// Converts an integer to a string like '10k' or '1.5M'.
    public func toFriendly() -> String {
        return self
            .formatted(
                .number
                .notation(.compactName)
                .precision(.fractionLength(0...2))
            )
    }
}
