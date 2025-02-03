//
//  ContentView.swift
//  Echo
//
//  Created by Tom Knighton on 27/01/2025.
//

import SwiftUI
import Onboarding
import API
import User
import Env

struct RootView: View {
    @State private var router: Router = .init()
    
    var body: some View {
        TabView(selection: $router.selectedTab) {
            ForEach(AppTab.allCases) { tab in
                Tab(tab.title, systemImage: tab.icon, value: tab) {
                    AppTabRootView(tab: tab)
                        .tag(tab)
                }
            }
        }
        .environment(router)
    }
}

#Preview {
    RootView()
}
