//
//  AppTab.swift
//  Env
//
//  Created by Tom Knighton on 02/02/2025.
//

public enum AppTab: String, CaseIterable, Identifiable, Hashable, Sendable {
    case posts, search, profile, settings
    
    public var id: String { rawValue }
    
    public var icon: String {
        switch self {
        case .posts: return "square.stack"
        case .search: return "magnifyingglass"
        case .profile: return "person"
        case .settings: return "gear"
        }
    }
    
    public var title: String {
        switch self {
        case .posts:
            return "Posts"
        case .search:
            return "Search"
        case .profile:
            return "Profile"
        case .settings:
            return "Settings"
        }
    }
}
