//
//  RedditSortOption.swift
//  Models
//
//  Created by Tom Knighton on 06/02/2025.
//

import API

public enum RedditSortOption: String {
    case hot = "HOT"
    case new = "NEW"
    case rising = "RISING"
    case top = "TOP"
    case topDaily = "TOP_DAILY"
    case topWeekly = "TOP_WEEKLY"
    case topMonthly = "TOP_MONTHLY"
    case topYearly = "TOP_YEARLY"
    case topAll = "TOP_ALL"
    case controversial = "CONTROVERSIAL"
    case controversialDaily = "CONTROVERSIAL_DAILY"
    case controversialWeekly = "CONTROVERSIAL_WEEKLY"
    case controversialMonthly = "CONTROVERSIAL_MONTHLY"
    case controversialYearly = "CONTROVERSIAL_YEARLY"
    case controversialAll = "CONTROVERSIAL_ALL"
    
    case best = "BEST"
    case qAndA = "Q_AND_A"
}

extension RedditSortOption: Sendable {
    
}

extension RedditSortOption {
    public func toGQL() -> EchoAPI.RedditSortOption {
        return EchoAPI.RedditSortOption(rawValue: self.rawValue) ?? .top
    }
    
    public static func fromGQL(_ gql: EchoAPI.RedditSortOption) -> RedditSortOption {
        return RedditSortOption(rawValue: gql.rawValue) ?? .top
    }
}
