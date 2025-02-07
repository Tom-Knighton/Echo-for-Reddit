//
//  String+Echo.swift
//  Env
//
//  Created by Tom Knighton on 06/02/2025.
//

extension String {
    
    public func truncate(length: Int) -> String {
        return (self.count > length) ? self.prefix(length) + "..." : self
    }
}
