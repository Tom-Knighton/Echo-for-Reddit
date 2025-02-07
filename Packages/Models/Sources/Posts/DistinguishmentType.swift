//
//  DistinguishmentType.swift
//  Models
//
//  Created by Tom Knighton on 06/02/2025.
//

public enum DistinguishmentType: String {
    case moderator = "moderator"
    case admin = "admin"
    case special = "special"
    case none = "none"
}

extension DistinguishmentType: Sendable {}
