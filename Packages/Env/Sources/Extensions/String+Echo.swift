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
    
    public func extractSubreddit() -> String? {
        let noQuery = self.components(separatedBy: "?").first ?? self

        if noQuery.localizedCaseInsensitiveContains("reddit.com") {
            var working = noQuery
            if let schemeRange = working.range(of: "://") {
                working = String(working[schemeRange.upperBound...])
            }
            let components = working.split(separator: "/").map { String($0) }
            if components.count > 2, components[1].lowercased() == "r" {
                return components[2]
            }
            if components.count >= 3, components[0].localizedCaseInsensitiveContains("reddit.com") {
                return components[2]
            }
        }
        
        let trimmed = noQuery.hasPrefix("/") ? String(noQuery.dropFirst()) : noQuery
        let components = trimmed.split(separator: "/")
        if components.count >= 2, components[0].lowercased() == "r" {
            return String(components[1])
        }
        return nil
    }
    
    func friendly(num: Int) -> String {
        return num.formatted(.number.grouping(.automatic).sign(strategy: .always()))
    }
}
