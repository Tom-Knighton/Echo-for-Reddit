//
//  AppTabs.swift
//  Echo
//
//  Created by Tom Knighton on 02/02/2025.
//

import SwiftUI
import Env
import User

struct AppTabRootView: View {
    @Environment(Router.self) private var router
    
    let tab: AppTab
    
    var body: some View {
        @Bindable var router = router
        
        GeometryReader { _ in
            NavigationStack(path: $router[tab]) {
                tab.rootView
            }
        }
        .ignoresSafeArea()
    }
}

@MainActor
extension AppTab {
    @ViewBuilder
    fileprivate var rootView: some View {
        switch self {
        case .posts:
            Text("TODO")
        case .search:
            Text("TODO")
        case .profile:
            UserPageView()
        case .settings:
            Text("TODO")
        }
    }
}
