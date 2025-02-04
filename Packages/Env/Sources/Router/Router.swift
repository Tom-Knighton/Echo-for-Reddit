//
//  Router.swift
//  Env
//
//  Created by Tom Knighton on 02/02/2025.
//

import SwiftUI

@Observable
@MainActor
public final class Router {
    private var paths: [AppTab: [RouterDestination]] = [:]
    
    public subscript(tab: AppTab) -> [RouterDestination] {
        get { paths[tab] ?? [] }
        set { paths[tab] = newValue }
    }
    
    public var selectedTab: AppTab = .posts
    
    public init() {
        
    }
    
    public var currentPath: [RouterDestination] {
        paths[selectedTab] ?? []
    }
    
    public func popToRoot(for tab: AppTab? = nil) {
        paths[tab ?? selectedTab] = []
    }
    
    public func pop(for tab: AppTab? = nil) {
        paths[tab ?? selectedTab]?.removeLast()
    }
    
    public func push(_ destination: RouterDestination, for tab: AppTab? = nil) {
        if paths[tab ?? selectedTab] == nil {
            paths[tab ?? selectedTab] = [destination]
        } else {
            paths[tab ?? selectedTab]?.append(destination)
        }
    }
}
